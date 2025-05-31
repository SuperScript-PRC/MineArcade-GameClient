package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.Pool;

    public class DialLag implements ClientPacket {
        public var dialUUID:String;

        public function DialLag(dialUUID:String = undefined):void {
            this.dialUUID = dialUUID
        }   

        public function ID():int {
            return Pool.IDDialLag
        }

        public function Marshal(w:ByteArray):void {
            w.writeUTF(this.dialUUID)
        }
    }
}
