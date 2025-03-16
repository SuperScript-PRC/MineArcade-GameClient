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

// type PublicMineAreaChunk struct {
// 	ChunkX int32
// 	ChunkY int32
// 	// 一个区块包含 64x64 个方块
// 	// []xy
// 	ChunkData []byte
// }

// func (p *PublicMineAreaChunk) ID() uint32 {
// 	return IDPublicMineareaChunk
// }

// func (p *PublicMineAreaChunk) Marshal(w *protocol.Writer) {
// 	w.Int32(p.ChunkX)
// 	w.Int32(p.ChunkY)
// 	w.Bytes(p.ChunkData)
// }
