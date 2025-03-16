package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import MineArcade.protocol.packets.ClientPacket;

    public class Writer {
        private var socket:Socket;

        public function Writer(sock:Socket) {
            socket = sock;
        }

        public function WritePacket(pk:ClientPacket):void {
            var buf:ByteArray = this.construct_writer(pk.ID());
            pk.Marshal(buf);
            this.socket.writeBytes(buf);
            this.socket.flush()
        }

        private function construct_writer(pkID:Number):ByteArray {
            var buf:ByteArray = new ByteArray();
            buf.writeInt(pkID);
            return buf
        }
    }
}
