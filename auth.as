package {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.crypto.MD5;

    public class auth {
        private socket: Socket;
        private var is_success: Function;
        private var onConnect:Function = function(event:Event) {
            auth_msg = JSON.stringify(constructAuthMessage(username, password));
            sendMessage(auth_msg);
        };
        private var onClose:Function = function(event:Event) {
            is_success(false, "连接中断")
        };
        private var onData:Function = function(event:ProgressEvent) {
            var data:ByteArray = new ByteArray();
            var response
            socket.readBytes(data);
            var message:String = data.readUTFBytes(data.length);
            try {
                response: Object = JSON.parse(message);
            } catch(e: Error) {
                is_success(false, "Invalid JSON response");
                return;
            }
            if (!response["Success"]) {
                is_success(false, response["Message"]);
                return;
            }
            is_success(true, response["Message"]);
        };
        private var onError:Function = function(event:IOErrorEvent) {
            is_success(false, "连接中断: " + event.text);
        };
        private var onSecurityError:Function = function(event:SecurityErrorEvent) {
            is_success(false, "SecurityError: " + event.text);
        };

        public function auth(sock: Socket){
            socket = sock;
        }

        public function Auth(username:String, password:String, is_suc: Function) {
            is_success = is_suc;
        }

        private function constructAuthMessage(username:String, password:String){
            authMessage = {
                "Username": username,
                "Password": calculateMD5(password + "minearc#01")
            }
            return authMessage;
        }

        private function sendMessage(message:String) {
            var data:ByteArray = new ByteArray();
            data.writeUTFBytes(message);
            socket.writeBytes(data);
            socket.flush();
        }

        private function calculateMD5(input:String):String {
            var byteArray:ByteArray = new ByteArray();
            byteArray.writeUTFBytes(input);
            byteArray.position = 0;
            var md5:MD5 = new MD5();
            md5.update(byteArray);
            var hashBytes:ByteArray = md5.digest();
            return hashBytes.toHex();
        }

        private function setListeners(){
            socket.addEventListener(Event.CONNECT, onConnect);
            socket.addEventListener(Event.CLOSE, onClose);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
            socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        private function removeListeners(){
            socket.removeEventListener(Event.CONNECT, onConnect);
            socket.removeEventListener(Event.CLOSE, onClose);
            socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
            socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }
    }
}
