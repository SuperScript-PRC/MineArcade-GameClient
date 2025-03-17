package MineArcade.protocol {
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.Socket;
    import MineArcade.protocol.packets.ServerPacket;

    public class Connection {
        public var socket:Socket;
        private var pk_handler:PacketHandler;
        private var ip:String;
        private var port:Number;

        private var conn_listener:Function = function():void {
            trace("No connection listener")
        };
        private var disconn_listener:Function = function():void {
            trace("No disconnection listener")
        };
        private var error_listener:Function = function(e:String):void {
            trace("No error listener, error=" + e)
        };

        public function Connection(ip:String, port:Number) {
            this.socket = new Socket();
            this.ip = ip;
            this.port = port;
        }

        public function ConnectServer():void {
            this.socket.connect(ip, port);
        }

        public function hookHandler(hdl:PacketHandler):void {
            this.pk_handler = hdl;
        }

        public function hookConnectionListener(cb:Function):void {
            this.conn_listener = cb;
        }

        public function hookDisconnectionListener(cb:Function):void {
            this.disconn_listener = cb;
        }

        public function hookErrorListener(cb:Function):void {
            this.error_listener = cb;
        }

        private function onConnect(event:Event):void {
            this.conn_listener()
        }


        private function onClose(event:Event):void {
            this.disconn_listener()
        }


        private function onData(event:ProgressEvent):void {
            while (socket.bytesAvailable > 0) {
                var pk:ServerPacket = this.pk_handler.ReadPacket();
                this.pk_handler.handlePacket(pk);
            }
        }

        private function onError(event:IOErrorEvent):void {
            this.error_listener(event.text);
        }

        private function onSecurityError(event:SecurityErrorEvent):void {
            this.error_listener(event.text);
        }

        public function setListeners():void {
            this.socket.addEventListener(Event.CONNECT, onConnect);
            this.socket.addEventListener(Event.CLOSE, onClose);
            this.socket.addEventListener(ProgressEvent.SOCKET_DATA, onData);
            this.socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
            this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        public function removeListeners():void {
            this.socket.removeEventListener(Event.CONNECT, onConnect);
            this.socket.removeEventListener(Event.CLOSE, onClose);
            this.socket.removeEventListener(ProgressEvent.SOCKET_DATA, onData);
            this.socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        }

        public function close():void {
            this.removeListeners()
            this.socket.close()
        }
    }
}
