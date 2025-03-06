package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;

    public class socket_conn {

        private var socket:Socket;

        public function socket_conn() {
            socket = new Socket();

            socket.addEventListener(Event.CONNECT, onConnect);
            socket.addEventListener(Event.CLOSE, onClose);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
            socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

            socket.connect("127.0.0.1", 6000);
        }

        private function onConnect(event:Event):void {
            trace("Connected to server.");
            // 发送初始消息
            sendMessage("Hello Server!");
        }

        private function onClose(event:Event):void {
            trace("Connection closed.");
        }

        private function onData(event:ProgressEvent):void {
            var data:ByteArray = new ByteArray();
            socket.readBytes(data);
            var message:String = data.readUTFBytes(data.length);
            trace("Received message: " + message);
        }

        private function onError(event:IOErrorEvent):void {
            trace("IOError: " + event.text);
        }

        private function onSecurityError(event:SecurityErrorEvent):void {
            trace("SecurityError: " + event.text);
        }

        private function sendMessage(message:String):void {
            var data:ByteArray = new ByteArray();
            data.writeUTFBytes(message);
            socket.writeBytes(data);
            socket.flush();
        }
    }
}