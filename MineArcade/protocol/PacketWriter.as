package MineArcade.protocol {
    import flash.net.Socket;
    import MineArcade.protocol.packets.ClientPacket;
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.PacketNetType;
    import MineArcade.core.CorArcade;

    public class PacketWriter {
        private var tcp_socket:Socket;
        private var udp_socket:*;

        function PacketWriter() {
        }

        public function SetTCPSocket(socket:Socket):void {
            this.tcp_socket = socket;
        }

        public function SetUDPSocket(socket:*):void {
            this.udp_socket = socket;
        }

        public function WritePacket(pk:ClientPacket):void {
            if (!this.tcp_socket.connected)
                return;
            var buf:ByteArray = new ByteArray();
            // trace("write: " + pk.ID() + " = " + JSON.stringify(pk))
            buf.writeInt(pk.ID())
            pk.Marshal(buf);
            switch (pk.NetType()) {
                case PacketNetType.TCP:
                    this.tcp_socket.writeInt(buf.length)
                    this.tcp_socket.writeBytes(buf)
                    this.tcp_socket.flush()
                    break;
                case PacketNetType.UDP:
                    var newBuf:ByteArray = new ByteArray();
                    newBuf.writeInt(buf.length)
                    newBuf.writeBytes(buf)
                    this.udp_socket.send(newBuf, 0, newBuf.length, CorArcade.UDPAddress, CorArcade.UDPPort)
                    break;
            }
        }
    }
}
