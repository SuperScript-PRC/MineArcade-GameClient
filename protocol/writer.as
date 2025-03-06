package protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import protocol.packet_ids

    public class writer {
        var socket: Socket;

        public function writer(sock: Socket){
            socket = sock;
        }
        private function construct_writer(pkID: Number): ByteArray {
            var buf = new ByteArray();
            buf.writeByte(pkID & 0xFFFF >> 2);
            buf.writeByte(pkID & 0xFF);
            return buf;
        }

        public function ClientLogin(username: String, passwordMD5: String): ByteArray {
            var buf = construct_writer(packet_ids.IDClientLogin);
            buf.writeUTF(username);
            buf.writeUTF(passwordMD5);
            return buf;
        }
        public function DialLog(dialUUID: String): ByteArray {
            var buf = construct_writer(packet_ids.IDDialLog);
            buf.writeUTF(dialUUID);
            return buf;
        }
        public function SimpleEvent(eventType: Number, eventData: Number): ByteArray {
            var buf = construct_writer(packet_ids.IDSimpleEvent);
            buf.writeInt(eventType);
            buf.writeInt(eventData);
            return buf;
        }
    }
}
