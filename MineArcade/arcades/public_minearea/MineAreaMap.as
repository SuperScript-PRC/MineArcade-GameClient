package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.PublicMineAreaChunk;
    import MineArcade.protocol.packets.PublicMineareaPlayerActorData;
    import MineArcade.define.StageData;
    import flash.events.MouseEvent;
    import MineArcade.fixer.EventContext;
    import flash.events.Event;
    import flash.utils.getTimer;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.protocol.packets.PublicMineareaBlockEvent;
    import MineArcade.gui.TopMessage;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

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

        public function MineAreaMap(core:CorArcade):void {
            this.core = core
        }

        public function Entry():void {
            this.core.getPacketHander().addPacketListenerBoundingMC(this, Pool.IDPublicMineAreaChunk, this.handleChunk)
            this.core.getPacketHander().addPacketListenerBoundingMC(this, Pool.IDPublicMineareaBlockEvent, this.handleBlockModified)
            this.core.getPacketHander().addPacketListenerBoundingMC(this, Pool.IDPublicMineareaPlayerActorData, this.handlePlayer)
            EventContext.Create(this, StageMC.stage, MouseEvent.MOUSE_DOWN, this.handleMouseDown)
            EventContext.Create(this, StageMC.stage, MouseEvent.MOUSE_UP, this.handleMouseUp)
            EventContext.Create(this, StageMC.stage, KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void{
                if (e.keyCode == Keyboard.CONTROL) {
                    displayMousePosition()
                }
            })
        }

        public function AddPlayer(playername:String, uuid:String, x:int, y:int, is_client_player:Boolean):void {
            var p:WorldPlayer = new WorldPlayer(playername, uuid, is_client_player, this)
            if (p.is_cli_player)
                this.client_player = p
            if (players[p.uuid] != undefined) {
                trace("[PublicMineArea] 警告: 玩家 UUID=" + p.uuid + " 已存在。")
                return
            }
            players[p.uuid] = p
            this.addChild(p)
        }

        public function RemovePlayer(uuid:String):void {
            if (players[uuid] != undefined) {
                trace("[PublicMineArea] 警告: 玩家 UUID=" + uuid + " 不存在。")
                return
            }
            this.removeChild(players[uuid])
            delete players[uuid]
        }

        public function MapMoveRelative():void {
            var p:WorldPlayer = this.client_player
            this.x = StageData.StageWidth / 2 - p.x
            this.y = StageData.StageHeight / 2 - p.y
        }

        public function GetBlock(blockX:int, blockY:int):MineBlock {
            var chunk_x:int = int(blockX / 16)
            var chunk_y:int = int(blockY / 16)
            var chunk_block_x:int = int(blockX % 16)
            var chunk_block_y:int = int(blockY % 16)
            var index:int = Chunk.GetMapIndexByChunkXY(chunk_x, chunk_y)
            if (chunk_x < 0 || chunk_x >= 32 || chunk_y < 0 || chunk_y >= 32)
                return null
            else if (index < 0 || index >= 1024)
                return null
            const chunk:Chunk = this.chunks[Chunk.GetMapIndexByChunkXY(chunk_x, chunk_y)]
            if (chunk == null) throw new Error("Chunk not found: " + chunk_block_x + ", " + chunk_block_y)
            return chunk.GetBlock(chunk_block_x, chunk_block_y)
        }

        private function handleChunk(pk:PublicMineAreaChunk):void {
            var chunkX:int = pk.ChunkX
            var chunkY:int = pk.ChunkY
            var chunk_bts:ByteArray = pk.ChunkData
            if (chunk_bts == null)
                this.removeChunk(chunkX, chunkY)
            else
                this.addChunk(new Chunk(chunkX, chunkY, chunk_bts))
        }

        private function handleBlockModified(pk:PublicMineareaBlockEvent):void {
            this.modifyBlockAt(pk.BlockX, pk.BlockY, pk.NewBlock)
        }

        private function handlePlayer(pk:PublicMineareaPlayerActorData):void {
            if (pk.Action == 1)
                this.AddPlayer(pk.Nickname, pk.UUIDStr, pk.X, pk.Y, pk.UUIDStr == this.client_player.uuid)
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
            this.digger = new BlockDestroyStage()
            this.addChild(digger)
            this.addEventListener(Event.ENTER_FRAME, this.onRepeatDown)
            this.mouse_down_time = getTimer()
        }

        private function handleMouseUp(e:MouseEvent):void {
            // tests
            if (getTimer() - this.mouse_down_time < 250) {
                this.modifyBlockAt(int(this.mouseX / 32), int(512 - this.mouseY / 32), 6, true)
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
                    var now_digging_block:MineBlock = this.GetBlock(int(this.mouseX / 32), 511 - int(this.mouseY / 32))
                    if (now_digging_block.is_hidden) return
                    if (this.now_digging_block_x != now_digging_block.X || this.now_digging_block_y != now_digging_block.Y) {
                        // 切换挖掘了其他的方块
                        this.mouse_down_time = getTimer() - 250
                        this.now_digging_block_x = now_digging_block.X
                        this.now_digging_block_y = now_digging_block.Y
                        this.digger.x = now_digging_block.X * 32
                        this.digger.y = (511 - now_digging_block.Y) * 32
                    } else {
                        var dig_process:int = int((getTimer() - this.mouse_down_time - 250) * this.client_player.dig_speed / 100)
                        if (dig_process < 10) {
                            this.digger.UpdateStatus(dig_process)
                        } else {
                            this.modifyBlockAt(now_digging_block.X, now_digging_block.Y, 0, true)
                            this.digger.UpdateStatus(10)
                            this.mouse_down_time = getTimer() - 250
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
                trace("[Warning] Chunk x=" + chunkX + " y=" + chunkY + " not found, can't be removed")
                return
            }
            this.removeChild(chk)
            chunks[index] = null
        }

        private function modifyBlockAt(blockX:int, blockY:int, newID:int, from_local:Boolean = false):Boolean {
            var chunk_x:int = int(blockX / 16)
            var chunk_y:int = int(blockY / 16)
            var chunk_block_x:int = int(blockX % 16)
            var chunk_block_y:int = int(blockY % 16)
            var index:int = Chunk.GetMapIndexByChunkXY(chunk_x, chunk_y)
            if (chunk_x < 0 || chunk_x >= 32 || chunk_y < 0 || chunk_y >= 32)
                return false
            else if (index < 0 || index >= 1024)
                return false
            const chunk:Chunk = this.chunks[index]
            chunk.ModifyBlock(blockX, blockY, newID)
            if (from_local)
                core.getPacketWriter().WritePacket(new PublicMineareaBlockEvent(blockX, blockY, newID))
            return true
        }

        private function displayMousePosition():void{
            var block_x: int = int(this.mouseX / 32)
            var block_y: int = 511 - int(this.mouseY / 32)
            var chunk_x: int = int(block_x / 16)
            var chunk_y: int = int(block_y / 16)
            var block:MineBlock = this.GetBlock(block_x, block_y)
            var block_type: int;
            if (block != null)
                block_type = block.id
            else
                block_type = -1
            TopMessage.show("当前坐标: 区块 (" + chunk_x + ", " + chunk_y + "), 方块 (" + block_x + ", " + block_y + "), type: " + block_type)
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
