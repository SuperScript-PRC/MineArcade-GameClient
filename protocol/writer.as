package {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    public class writer {
        var socket: Socket;

        public var IDLogin = 1;
        
        public function writer(sock: Socket){
            socket = sock;
        }

        public function Login(username: String, passwordMD5: String){
            var buf = new ByteArray();
            buf.writeByte(IDLogin)
            buf.writeUTF(username);
            buf.writeUTF(passwordMD5);
            socket.writeBytes(buf);
        }
    }
}
