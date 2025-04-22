package MineArcade.protocol {
    import flash.net.Socket;
    import MineArcade.protocol.packets.ClientPacket;
    import flash.utils.ByteArray;

    public class Writer {
        private var socket:Socket;

        public function Writer(sock:Socket) {
            socket = sock;
        }

        public function WritePacket(pk:ClientPacket):void {
            if (!this.socket.connected)
                return;
            var buf:ByteArray = new ByteArray();
            buf.writeInt(pk.ID())
            pk.Marshal(buf);
            this.socket.writeInt(buf.length)
            this.socket.writeBytes(buf)
            this.socket.flush()
        }
    }
}
