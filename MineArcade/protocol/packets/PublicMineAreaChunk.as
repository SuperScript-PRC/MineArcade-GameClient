package MineArcade.protocol.packets {
    import flash.net.Socket;
    import flash.utils.ByteArray;

    public class PublicMineAreaChunk implements ServerPacket {
        public var ChunkX:int;
        public var ChunkY:int;
        public var ChunkData:ByteArray;

        public function PublicMineAreaChunk(ChunkX:int = undefined, ChunkY:int = undefined, ChunkData:ByteArray = undefined):void {
            this.ChunkX = ChunkX
            this.ChunkY = ChunkY
            this.ChunkData = ChunkData
        }

        public function ID():int {
            return Pool.IDPublicMineAreaChunk
        }

        public function Unmarshal(r:Socket):void {
            this.ChunkX = r.readInt();
            this.ChunkY = r.readInt();
            this.ChunkData = new ByteArray();
            var chunkLength:Number = r.readInt();
            if (chunkLength != 256 && chunkLength != 0)
                throw new Error("ChunkData length error: " + this.ChunkData.length);
            if (chunkLength > 0)
                r.readBytes(this.ChunkData, 0, chunkLength);
            else
                this.ChunkData = null
        }
    }


}
