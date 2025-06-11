package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class ClientLoginResp implements ServerPacket {
        public var Success:Boolean;
        public var Message:String;
        public var StatusCode:int;

        public function ClientLoginResp(Success:Boolean = undefined, Message:String = undefined, StatusCode:int = undefined):void {
            this.Success = Success
            this.Message = Message
            this.StatusCode = StatusCode
        }

        public function ID():int {
            return PacketIDs.IDClientLoginResp
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            Success = r.readBoolean()
            Message = r.readUTF()
            StatusCode = r.readByte()
        }
    }
}
