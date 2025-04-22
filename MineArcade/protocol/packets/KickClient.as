package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class KickClient implements ServerPacket {
        public var Message:String;
        public var StatusCode:int;

        public function KickClient(Message:String = undefined, StatusCode:int = undefined):void {
            this.Message = Message
            this.StatusCode = StatusCode
        }

        public function ID():int {
            return Pool.IDKickClient
        }

        public function Unmarshal(r:ByteArray):void {
            Message = r.readUTF()
            StatusCode = r.readInt()
        }
    }
}
