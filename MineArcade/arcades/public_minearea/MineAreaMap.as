package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.core.CorArcade;
    import MineArcade.define.StageData;
    import flash.events.MouseEvent;
    import MineArcade.fixer.EventContext;
    import flash.events.Event;
    import flash.utils.getTimer;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.gui.TopMessage;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import MineArcade.protocol.packets.arcade.public_minearea.*;

    public class MineAreaMap extends MovieClip {
        private var core:CorArcade
        public var chunks:Vector.<Chunk> = new Vector.<Chunk>(1024)
        public var players:Object = {}
        public var client_player:WorldPlayer
        public const G:Number = 0.5
        private var digger:BlockDestroyStage;
        // other settings
        private var mouse_down_time:Number = 0
        private var now_digging_block_x:int = 0;
        private var now_digging_block_y:int = 0;

        private var start_x: Number;
        private var start_y: Number;

        function MineAreaMap(core:CorArcade){
            this.core = core
        }

        public function Entry():void {
            this.core.getPacketHander().addPacketListenerBoundingMC(this, PacketIDs.IDPublicMineAreaChunk, this.handleChunk)
            this.core.getPacketHander().addPacketListenerBoundingMC(this, PacketIDs.IDPublicMineareaBlockEvent, this.handleBlockModified)
            this.core.getPacketHander().addPacketListenerBoundingMC(this, PacketIDs.IDPublicMineareaPlayerActorData, this.handlePlayer)
            EventContext.Create(this, StageMC.stage, MouseEvent.MOUSE_DOWN, this.handleMouseDown)
            EventContext.Create(this, StageMC.stage, MouseEvent.MOUSE_UP, this.handleMouseUp)
            EventContext.Create(this, StageMC.stage, KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void{
                if (e.keyCode == Keyboard.CONTROL) {
                    displayMousePosition()
                }
                if (e.keyCode == Keyboard.G) {
                    start_x = mouseX
                    start_y = mouseY
                }
            })
            EventContext.Create(this, StageMC.stage, KeyboardEvent.KEY_UP, function (e:KeyboardEvent):void{
                if (e.keyCode == Keyboard.G) {
                    var end_x: Number = mouseX
                    var end_y: Number = mouseY
                    var mc:MovieClip = new MovieClip()
                    mc.graphics.lineStyle(5, 0xff0000)
                    mc.graphics.moveTo(start_x, start_y)
                    mc.graphics.lineTo(end_x, end_y)
                    addChild(mc)
                    for each (var chunk:Chunk in chunks){
                        if (chunk == null) continue
                        var chunk_x: Number = chunk.chunkX * 512
                        var chunk_y: Number = 16272 - chunk.chunkY * 512
                        for each (var block:MineBlock in chunk.blocks){
                            var block_x: Number = chunk_x + block.X * 32
                            var block_y: Number = chunk_y + 480 - block.Y * 32
                            // if (block.hitTestPoint(mc)) {
                            //     modifyBlockAt(block.X, block.Y, 0)
                            // }
                        }
                    }
                }
            })
        }

        public function AddPlayer(playername:String, uid:String, x:int, y:int, is_client_player:Boolean):void {
            var p:WorldPlayer = new WorldPlayer(playername, uid, is_client_player, this)
            if (p.is_cli_player)
                this.client_player = p
            if (players[p.uid] != undefined) {
                trace("[PublicMineArea] 警告: 玩家 UUID=" + p.uid + " 已存在。")
                return
            }
            players[p.uid] = p
            this.addChild(p)
        }

        public function RemovePlayer(uid:String):void {
            if (players[uid] != undefined) {
                trace("[PublicMineArea] 警告: 玩家 UUID=" + uid + " 不存在。")
                return
            }
            this.removeChild(players[uid])
            delete players[uid]
        }

        public function MapMoveRelative():void {
            var p:WorldPlayer = this.client_player
            this.x = StageData.StageWidth / 2 - p.x
            this.y = StageData.StageHeight / 2 - p.y
        }

        public function GetChunk(chunkX:int, chunkY:int, ignore_faults:Boolean=false):Chunk {
            if (chunkX < 0 || chunkX >= define.MAP_BORDER_CHUNK_X || chunkY < 0 || chunkY >= define.MAP_BORDER_CHUNK_Y)
                return null
            var chunk:Chunk = this.chunks[Chunk.GetMapIndexByChunkXY(chunkX, chunkY)]
            if (chunk == null)
                if(!ignore_faults)
                    throw new Error("Chunk not found: " + chunkX + ", " + chunkY)
                else
                    return null
            return chunk
        }

        public function GetBlock(blockX:int, blockY:int, ignore_faults:Boolean=false):MineBlock {
            if (blockX < 0 || blockX >= define.MAP_BORDER_X || blockY < 0 || blockY >= define.MAP_BORDER_X)
                return null
            var chunk:Chunk = this.GetChunk(int(blockX / define.CHUNK_SIZE), int(blockY / define.CHUNK_SIZE), ignore_faults)
            if (chunk == null)
                return null
            return chunk.GetBlock(blockX % define.CHUNK_SIZE, blockY % define.CHUNK_SIZE)
        }

        public function BlockPositionToAbsolutePosition(blockX: int, blockY: int):Object{
            return {
                x: blockX * define.BLOCK_SIZE + this.x,
                y: ((define.MAP_BORDER_Y - 1 - blockY) * define.BLOCK_SIZE) + this.y
            }
        }

        private function handleChunk(pk:PublicMineAreaChunk):void {
            var chunkX:int = pk.ChunkX
            var chunkY:int = pk.ChunkY
            var chunk_bts:ByteArray = pk.ChunkData
            if (chunk_bts == null)
                this.removeChunk(chunkX, chunkY)
            else
                {
                    var chk:Chunk = new Chunk(chunkX, chunkY, chunk_bts)
                    this.addChunk(chk)
                    chk.ActivateAndUpdate(this)
                }
        }

        private function handleBlockModified(pk:PublicMineareaBlockEvent):void {
            this.modifyBlockAt(pk.BlockX, pk.BlockY, pk.NewBlock)
        }

        private function handlePlayer(pk:PublicMineareaPlayerActorData):void {
            if (pk.Action == 1)
                this.AddPlayer(pk.Nickname, pk.UUIDStr, pk.X, pk.Y, pk.UUIDStr == this.client_player.uid)
            else if (pk.Action == 2)
                this.RemovePlayer(pk.UUIDStr)
            else if (pk.Action == 0) {
                var wp:WorldPlayer = players[pk.UUIDStr]
                if (wp) {
                    wp.UpdateFromPacket(pk)
                } else {
                    trace("[PublicMineArea] 警告: 玩家 UUID=" + pk.UUIDStr + " 不存在。")
                }
            } else {
                trace("[PublicMineArea] 警告: 暂时无法处理玩家行为类型: " + pk.Action)
            }
        }

        private function handleMouseDown(e:MouseEvent):void {
            if (this.digger != null) {
                this.removeChild(this.digger)
                this.digger = null
            }
            this.digger = new BlockDestroyStage()
            this.addChild(digger)
            this.addEventListener(Event.ENTER_FRAME, this.onRepeatDown)
            this.mouse_down_time = getTimer()
        }

        private function handleMouseUp(e:MouseEvent):void {
            // tests
            if (getTimer() - this.mouse_down_time < 250) {
                var blockX: int = int(this.mouseX / define.BLOCK_SIZE)
                var blockY: int = int(define.MAP_BORDER_Y - this.mouseY / define.BLOCK_SIZE)
                var current_block: MineBlock = this.GetBlock(blockX, blockY)
                if (Math.pow(current_block.X * define.BLOCK_SIZE - this.client_player.x, 2) + Math.pow((define.MAP_BORDER_Y - current_block.Y) * define.BLOCK_SIZE - this.client_player.y, 2) > Math.pow(define.PLAYER_BUILD_DISTANCE * define.BLOCK_SIZE, 2)) 
                    return
                if (current_block.AirNearby(this) == 4) return
                if (current_block.id != 0) return
                this.modifyBlockAt(blockX, blockY, 1, true)
            }
            this.removeEventListener(Event.ENTER_FRAME, this.onRepeatDown)
            if (this.digger != null) {
                this.removeChild(this.digger)
                this.digger = null
            }
        }

        private function onRepeatDown(_:*):void {
            try {
                if (this.root == null) {
                    this.removeEventListener(Event.ENTER_FRAME, this.onRepeatDown)
                    return
                }
                // 尝试挖掘方块
                if (getTimer() - this.mouse_down_time > 250) {
                    var now_digging_block:MineBlock = this.GetBlock(int(this.mouseX / define.BLOCK_SIZE), define.MAP_BORDER_Y - 1 - int(this.mouseY / define.BLOCK_SIZE))
                    if (now_digging_block.is_hidden) return
                    // 手臂操作距离
                    if (Math.pow(now_digging_block.X * define.BLOCK_SIZE - this.client_player.x, 2) + Math.pow((define.MAP_BORDER_Y - now_digging_block.Y) * define.BLOCK_SIZE - this.client_player.y, 2) > Math.pow(define.PLAYER_MINE_DISTANCE * define.BLOCK_SIZE, 2)) 
                        return
                    if (this.now_digging_block_x != now_digging_block.X || this.now_digging_block_y != now_digging_block.Y) {
                        // 切换挖掘了其他的方块
                        this.now_digging_block_x = now_digging_block.X
                        this.now_digging_block_y = now_digging_block.Y
                        this.mouse_down_time = getTimer() - 250
                    } else {
                        this.digger.x = now_digging_block.X * define.BLOCK_SIZE
                        this.digger.y = (define.CHUNK_BORDER_SIZE - 1 - now_digging_block.Y) * define.BLOCK_SIZE
                        var dig_process:int = int((getTimer() - this.mouse_down_time - 250) * this.client_player.dig_speed / 20 / now_digging_block.hard)
                        if (dig_process < 10) {
                            this.digger.UpdateStatus(dig_process)
                        } else {
                            this.modifyBlockAt(now_digging_block.X, now_digging_block.Y, 0, true)
                            this.digger.UpdateStatus(10)
                            this.mouse_down_time = getTimer() - 250
                            this.spawnDropItemByBlock(now_digging_block)
                        }
                    }
                }
            } catch (e) {
                removeEventListener(Event.ENTER_FRAME, this.onRepeatDown)
                throw e
            }

        }

        private function addChunk(chk:Chunk):void {
            chunks[Chunk.GetMapIndexByChunkXY(chk.chunkX, chk.chunkY)] = chk
            this.addChild(chk)
        }

        private function removeChunk(chunkX:int, chunkY:int):void {
            var index:int = Chunk.GetMapIndexByChunkXY(chunkX, chunkY)
            var chk:Chunk = chunks[index]
            if (chk == null) {
                trace("[PublicMineArea] Warning: Chunk x=" + chunkX + " y=" + chunkY + " not found, can't be removed")
                return
            }
            this.removeChild(chk)
            chunks[index] = null
        }

        private function modifyBlockAt(blockX:int, blockY:int, newID:int, from_local:Boolean = false):Boolean {
            var chunk_x:int = int(blockX / define.CHUNK_SIZE)
            var chunk_y:int = int(blockY / define.CHUNK_SIZE)
            var chunk_block_x:int = int(blockX % define.CHUNK_SIZE)
            var chunk_block_y:int = int(blockY % define.CHUNK_SIZE)
            var index:int = Chunk.GetMapIndexByChunkXY(chunk_x, chunk_y)
            if (chunk_x < 0 || chunk_x >= define.MAP_BORDER_X || chunk_y < 0 || chunk_y >= define.MAP_BORDER_CHUNK_Y)
                return false
            else if (index < 0 || index >= 1024)
                return false
            const chunk:Chunk = this.chunks[index]
            chunk.ModifyBlock(this, blockX, blockY, newID)
            if (from_local)
                core.getPacketWriter().WritePacket(new PublicMineareaBlockEvent(blockX, blockY, newID))
            return true
        }

        private function displayMousePosition():void{
            var block_x: int = int(this.mouseX / define.BLOCK_SIZE)
            var block_y: int = define.CHUNK_BORDER_SIZE - 1 - int(this.mouseY / define.BLOCK_SIZE)
            var chunk_x: int = int(block_x / define.CHUNK_SIZE)
            var chunk_y: int = int(block_y / define.CHUNK_SIZE)
            var block:MineBlock = this.GetBlock(block_x, block_y)
            var block_type: int;
            if (block != null)
                block_type = block.id
            else
                block_type = -1
            TopMessage.show("当前坐标: 区块 (" + chunk_x + ", " + chunk_y + "), 方块 (" + block_x + ", " + block_y + "), 类型: " + block_type)
        }

        private function spawnDropItemByBlock(block: MineBlock):void{
            const pos:Object = this.BlockPositionToAbsolutePosition(block.X, block.Y)
            const di:Class = MineDropItems.GetBlockDropItem(block.id)
            const dp:MineDropItem = new di(pos.x, pos.y)
            this.parent.addChild(dp)
        }

        // private function chunksGC():void {
        //     var i:int = 0
        //     for (i = 0; i < chunks.length; i++) {
        //         if (chunks[i].CanBeRemoved(this.client_player)) {
        //             this.removeChunk(chunks[i])
        //         }
        //     }
        // }
    }
}
