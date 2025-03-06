package {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    public class reader {
        var socket: Socket;

        public var IDLoginResp = 2;
        public var IDPlayerBasics = 4;
        
        public function reader(sock: Socket){
            socket = sock;
        }

        public function Read(){
            var buf: ByteArray;
            socket.readBytes(buf);
            pkID = buf.readByte();
            return pkID;
        }
        public function LoginResp(){
            var success: Boolean = socket.readBoolean();
            var message: String = socket.readUTF();
            var status_code: Number = socket.readByte();
            return {
                Success: success,
                Message: message
                StatusCode: status_code
            }
        }
        public function PlayerBasics(){
            var money = socket.readInt();
        }
    }
}
