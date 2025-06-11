package MineArcade.protocol.packets.arcade.public_minearea {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

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
            return PacketIDs.IDPublicMineareaBlockEvent
        }

        public function NetType(): int{
            return PacketNetType.UDP
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

