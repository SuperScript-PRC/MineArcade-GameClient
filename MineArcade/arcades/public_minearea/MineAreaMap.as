package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import MineArcade.core.Main;
    import flash.utils.ByteArray;
    import MineArcade.fixer.IntervalContext;
    import MineArcade.protocol.packets.Pool;

    public class MineAreaMap extends MovieClip {
        public var chunks:Vector.<Chunk> = new Vector.<Chunk>()
        public var G:Number = 0.5
        public var players:Vector.<WorldPlayer> = new Vector.<WorldPlayer>()
        public var client_player:WorldPlayer;

        public function Entry(playername:String):void {
            Main.GCore.getPacketHander().addPacketListener(Pool.IDPublicMineAreaChunk, this.handleChunk)
            IntervalContext.Create(this, this.chunksGC, 2000)
        }

        public function AddPlayer(playername:String, is_client_player:Boolean):void {
            var p:WorldPlayer = new WorldPlayer(playername, is_client_player, this)
            if (p.is_cli_player)
                this.client_player = p
            players.push(p)
            this.addChild(p)
        }

        public function handleChunk(pk:Object):void {
            var x:int = pk.x
            var y:int = pk.y
            var chunk_bts:ByteArray = pk.ChunkData
            var chk:Chunk = new Chunk(x, y, chunk_bts)
            this.addChunk(chk)
        }

        private function addChunk(chk:Chunk):void {
            chunks.push(chk)
            this.addChild(chk)
        }

        private function removeChunk(chk:Chunk):void {
            chunks.removeAt(chunks.indexOf(chk))
            this.removeChild(chk)
        }

        private function chunksGC():void {
            var i:int = 0
            for (i = 0; i < chunks.length; i++) {
                if (chunks[i].CanBeRemoved(this.client_player)) {
                    this.removeChunk(chunks[i])
                }
            }
        }
    }
}
