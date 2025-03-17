package MineArcade.protocol.packets {
    import flash.net.Socket;

    public class ServerHandshake implements ServerPacket {
        public var Success:Boolean;
        public var ServerVersion:int;
        public var ServerMessage:String;

        public function ServerHandshake(Success:Boolean = undefined, ServerVersion:int = undefined, ServerMessage:String = undefined):void {
            this.Success = Success
            this.ServerVersion = ServerVersion
            this.ServerMessage = ServerMessage
        }

        public function ID():int {
            return Pool.IDServerHandshake
        }

        public function Unmarshal(r:Socket):void {
            this.Success = r.readBoolean();
            this.ServerVersion = r.readInt();
            this.ServerMessage = r.readUTF();
        }
    }
}
