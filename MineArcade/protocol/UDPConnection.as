package MineArcade.protocol {
    import flash.net.DatagramSocket;
    import flash.events.DatagramSocketDataEvent;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.gui.TipWindow;

    public class UDPConnection {
        public var socket:DatagramSocket;
        private var pk_handler:PacketHandler;
        private var ip:String;
        private var port:Number;

        function UDPConnection(ip:String, port:Number) {
            this.ip = ip;
            this.port = port;
            var retries:int = 0;
            var bind_port:int = 34332;
            var sock:DatagramSocket;
            while (1)
                try {
                    sock = new DatagramSocket();
                    sock.bind(bind_port, "127.0.0.1");
                    break;
                } catch (e:Error) {
                    sock.close()
                    bind_port++;
                    retries++;
                    trace("Bind port on " + bind_port + ": " + e + ", retries: " + retries)
                    if (retries > 100) {
                        trace("Bind port failed, exiting.");
                        TipWindow.error("UDP 开启失败", 400, 200, function():void {
                            StageMC.Restart()
                        })
                        return;
                    }
                }
            this.socket = sock;
            this.socket.receive();
        }

        public function GetSocket():DatagramSocket {
            return this.socket;
        }

        public function HookHandler(hdl:PacketHandler):void {
            this.pk_handler = hdl;
        }

        private function onData(event:DatagramSocketDataEvent):void {
            var pk:ServerPacket = this.pk_handler.ReadUDPPacket(event.data);
            if (pk == null) {
                return;
            }
            this.pk_handler.handlePacket(pk);
        }

        public function setListeners():void {
            this.socket.addEventListener(DatagramSocketDataEvent.DATA, onData);
        }

        public function removeListeners():void {
            this.socket.removeEventListener(DatagramSocketDataEvent.DATA, onData);
        }

        public function close():void {
            this.removeListeners()
            this.socket.close()
        }
    }
}
