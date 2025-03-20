package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;
    import MineArcade.fixer.IntervalContext;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.PublicMineAreaChunk;
    import MineArcade.protocol.packets.PublicMineareaPlayerActorData;
    import MineArcade.define.StageData;

    public class MineAreaMap extends MovieClip {
        public var chunks:Vector.<Chunk> = new Vector.<Chunk>(1024)
        public var G:Number = 0.5
        public var players:Object = {}
        public var client_player:WorldPlayer
        public var core:CorArcade

        public function MineAreaMap(core:CorArcade):void {
            this.core = core
        }

        public function Entry():void {
            this.core.getPacketHander().addPacketListenerBoundingMC(this, Pool.IDPublicMineAreaChunk, this.handleChunk)
            this.core.getPacketHander().addPacketListenerBoundingMC(this, Pool.IDPublicMineareaPlayerActorData, this.handlePlayer)
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
            // this.x = 0
            // this.y = 0
            this.x = StageData.StageWidth / 2 - p.x
            this.y = StageData.StageHeight / 2 - p.y
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

        private function addChunk(chk:Chunk):void {
            chunks[Chunk.GetMapIndexByChunkXY(chk.chunkX, chk.chunkY)] = chk
            this.addChild(chk)
        }

        private function removeChunk(chunkX:int, chunkY:int):void {
            var index:int = Chunk.GetMapIndexByChunkXY(chunkX, chunkY)
            var chk:Chunk = chunks[index]
            if (chk == null) {
                trace("Chunk x="+chunkX+" y="+chunkY+" not found, can't be removed")
                return
            }
            this.removeChild(chk)
            chunks[index] = null
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
