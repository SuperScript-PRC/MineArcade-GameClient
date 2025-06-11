package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class KickClient implements ServerPacket {
        public var Message:String;
        public var StatusCode:int;

        public function KickClient(Message:String = undefined, StatusCode:int = undefined):void {
            this.Message = Message
            this.StatusCode = StatusCode
        }

        public function ID():int {
            return PacketIDs.IDKickClient
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            Message = r.readUTF()
            StatusCode = r[0]
        }
    }
}
