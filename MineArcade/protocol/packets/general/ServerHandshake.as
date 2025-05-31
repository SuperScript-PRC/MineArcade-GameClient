package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.PacketNetType;

    public class ServerHandshake implements ServerPacket {
        public var Success:Boolean;
        public var ServerVersion:int;
        public var ServerMessage:String;
        public var VerifyToken:String;

        public function ServerHandshake(Success:Boolean = undefined, ServerVersion:int = undefined, ServerMessage:String = undefined, VerifyToken:String=undefined):void {
            this.Success = Success
            this.ServerVersion = ServerVersion
            this.ServerMessage = ServerMessage
            this.VerifyToken = VerifyToken
        }

        public function ID():int {
            return Pool.IDServerHandshake
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            this.Success = r.readBoolean();
            this.ServerVersion = r.readInt();
            this.ServerMessage = r.readUTF();
            this.VerifyToken = r.readUTF();
        }
    }
}
