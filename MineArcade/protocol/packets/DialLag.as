package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class DialLag implements ClientPacket {
        public var dialUUID:String;

        public function ID():int {
            return Pool.IDDialLag
        }

        public function Marshal(w:ByteArray):void {
            w.writeUTF(this.dialUUID)
        }
    }
}
