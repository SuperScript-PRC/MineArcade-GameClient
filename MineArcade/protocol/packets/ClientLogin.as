package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class ClientLogin implements ClientPacket {
        public var Username: String;
        public var Password: String;

        public function ID():int{
            return Pool.IDClientLogin
        }

        public function Marshal(w:ByteArray):void{
            w.writeUTF(this.Username)
            w.writeUTF(this.Password)
        }
    }
}
