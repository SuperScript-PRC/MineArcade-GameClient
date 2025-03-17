package MineArcade.protocol.packets {
    import flash.net.Socket;

    public class DialLagResp implements ServerPacket {
        public var dialUUID:String;

        public function DialLagResp(dialUUID:String = undefined):void {
            this.dialUUID = dialUUID
        }

        public function ID():int {
            return Pool.IDDialLagResp
        }

        public function Unmarshal(r:Socket):void {
            dialUUID = r.readUTF()
        }
    }
}
