package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    public class Writer {
        private var socket:Socket;

        public function Writer(sock:Socket) {
            socket = sock;
        }

        private function construct_writer(pkID:Number):ByteArray {
            var buf:ByteArray = new ByteArray();
            buf.writeInt(pkID);
            return buf
        }

        // 数据包发送
        public function ClientHandshake(cli_version:int):void {
            var buf:ByteArray = construct_writer(PacketIDs.IDClientHandshake);
            buf.writeInt(cli_version);
            socket.writeBytes(buf);
            socket.flush()
        }

        public function ClientLogin(username:String, passwordMD5:String):void {
            var buf:ByteArray = construct_writer(PacketIDs.IDClientLogin);
            buf.writeUTF(username);
            buf.writeUTF(passwordMD5);
            socket.writeBytes(buf);
            socket.flush()
        }

        public function DialLog(dialUUID:String):void {
            var buf:ByteArray = construct_writer(PacketIDs.IDDialLag);
            buf.writeUTF(dialUUID);
            socket.writeBytes(buf);
            socket.flush()
        }

        public function SimpleEvent(eventType:Number, eventData:Number):void {
            var buf:ByteArray = construct_writer(PacketIDs.IDSimpleEvent);
            buf.writeInt(eventType);
            buf.writeInt(eventData);
            socket.writeBytes(buf);
            socket.flush()
        }
    }
}
