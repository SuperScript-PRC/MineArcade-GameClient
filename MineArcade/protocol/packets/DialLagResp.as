package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class DialLagResp implements ServerPacket {
        public var dialUUID:String;

        public function ID():int {
            return Pool.IDDialLagResp
        }

        public function Unmarshal(r:ByteArray):void {
            dialUUID = r.readUTF()
        }
    }
}
