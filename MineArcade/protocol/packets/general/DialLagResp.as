package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class DialLagResp implements ServerPacket {
        public var dialUUID:String;

        public function DialLagResp(dialUUID:String = undefined):void {
            this.dialUUID = dialUUID
        }

        public function ID():int {
            return PacketIDs.IDDialLagResp
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            dialUUID = r.readUTF()
        }
    }
}
