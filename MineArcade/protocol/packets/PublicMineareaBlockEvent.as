package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class PublicMineareaBlockEvent implements ClientPacket, ServerPacket {
        public var BlockX:int;
        public var BlockY:int;
        public var NewBlock:int;

        public function PublicMineareaBlockEvent(BlockX:int = undefined, BlockY:int = undefined, NewBlock:int = undefined):void {
            this.BlockX = BlockX
            this.BlockY = BlockY
            this.NewBlock = NewBlock
        }

        public function ID():int {
            return Pool.IDPublicMineareaBlockEvent
        }

        public function Unmarshal(r:ByteArray):void {
            this.BlockX = r.readInt();
            this.BlockY = r.readInt();
            this.NewBlock = r.readByte();
        }

        public function Marshal(w:ByteArray):void {
            w.writeInt(this.BlockX);
            w.writeInt(this.BlockY);
            w.writeByte(this.NewBlock);
        }
    }
}

