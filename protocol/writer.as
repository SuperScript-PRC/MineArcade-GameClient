package protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import protocol.packet_ids

    public class writer {
        private var socket: Socket;
        private const pkIDs: packet_ids = new packet_ids()

        public function writer(sock: Socket){
            socket = sock;
        }
        private function construct_writer(pkID: Number): ByteArray {
            var buf: ByteArray = new ByteArray();
            buf.writeByte(pkID & 0xFFFF >> 2);
            buf.writeByte(pkID & 0xFF);
            return buf
        }
        // 数据包发送
        public function ClientLogin(username: String, passwordMD5: String):void {
            var buf: ByteArray = construct_writer(pkIDs.IDClientLogin);
            buf.writeUTF(username);
            buf.writeUTF(passwordMD5);
            socket.writeBytes(buf);
        }
        public function DialLog(dialUUID: String): void {
            var buf: ByteArray = construct_writer(pkIDs.IDDialLag);
            buf.writeUTF(dialUUID);
            socket.writeBytes(buf);
        }
        public function SimpleEvent(eventType: Number, eventData: Number): void {
            var buf: ByteArray = construct_writer(pkIDs.IDSimpleEvent);
            buf.writeInt(eventType);
            buf.writeInt(eventData);
            socket.writeBytes(buf);
        }
    }
}
