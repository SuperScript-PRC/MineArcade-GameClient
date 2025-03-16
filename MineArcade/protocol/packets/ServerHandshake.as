package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class ServerHandshake implements ServerPacket {
        public var Success:Boolean;
        public var ServerVersion:int;
        public var ServerMessage:String;

        public function ID():int{
            return Pool.IDServerHandshake
        }

        public function Unmarshal(r:ByteArray):void{
            this.Success = r.readBoolean();
            this.ServerVersion = r.readInt();
            this.ServerMessage =r.readUTF();
        }
    }
}
