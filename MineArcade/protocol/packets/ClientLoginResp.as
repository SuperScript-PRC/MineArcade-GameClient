package MineArcade.protocol.packets {
    import flash.net.Socket;

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
            return Pool.IDClientLoginResp
        }

        public function Unmarshal(r:Socket):void {
            Success = r.readBoolean()
            Message = r.readUTF()
            StatusCode = r.readByte()
        }
    }
}
