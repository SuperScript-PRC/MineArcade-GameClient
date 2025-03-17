package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class PublicMineAreaChunk implements ServerPacket {
        public var ChunkX:int;
        public var ChunkY:int;
        public var ChunkData:ByteArray;

        public function ID():int {
            return Pool.IDPublicMineAreaChunk
        }

        public function Unmarshal(r:ByteArray):void {
            this.ChunkX = r.readInt();
            this.ChunkY = r.readInt();
            this.ChunkData = new ByteArray();
            r.readBytes(this.ChunkData, 256);
        }
    }


}
