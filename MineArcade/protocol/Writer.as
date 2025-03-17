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
            this.write_packet_header(pk.ID());
            pk.Marshal(this.socket);
            this.socket.flush()
        }

        private function write_packet_header(pkID:Number):void {
            this.socket.writeInt(pkID);
        }
    }
}
