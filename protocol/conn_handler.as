package protocol {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;

    public class conn_handler {
        private var socket: Socket;

        public function conn_handler(ip: String, port: Number) {
            socket = new Socket();
            socket.connect(ip, port);
        }

        private var onConnect: Function = function(event:Event):void {
        };
        private var onClose: Function = function(event:Event):void {
        };
    
        private var onData: Function = function(event:ProgressEvent):void {
        };
        private var onError: Function = function(event:IOErrorEvent):void {
        };
        private var onSecurityError: Function = function(event:SecurityErrorEvent):void {
        };

        private function setListeners():void{
            socket.addEventListener(Event.CONNECT, onConnect);
            socket.addEventListener(Event.CLOSE, onClose);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
            socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        private function removeListeners():void{
            socket.removeEventListener(Event.CONNECT, onConnect);
            socket.removeEventListener(Event.CLOSE, onClose);
            socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
            socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }
    }
}
