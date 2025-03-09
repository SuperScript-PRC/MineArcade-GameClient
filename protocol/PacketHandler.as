package protocol {

    public class PacketHandler extends Reader {
        private var packet_listeners:Object = {};

        public function PacketHandler(conn:Connection) {
            super(conn.socket);
        }

        public function addPacketListener(pkID:Number, listener:Function):void {
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                listeners = [];
            if (listeners is Array) {
                listeners.push(listener);
                packet_listeners[pkID] = listeners;
            }
        }

        public function removePacketListener(pkID:Number, listener:Function):void {
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                return;
            for (var i:Number = 0; i < listeners.length; i++) {
                if (listeners[i] == listener) {
                    listeners.splice(i, 1);
                    if (listeners.length == 0) {
                        delete packet_listeners[pkID];
                    }
                    break;
                }
            }
        }

        public function addPacketListenerOnce(pkID:Number, listener:Function):void {
            // hello
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                listeners = [];
            var fnc:Function = function(packet:Object):void {
                listener(packet);
                removePacketListener(pkID, fnc);
            }
            listeners.push(fnc);
            packet_listeners[pkID] = listeners;
        }

        public function handlePacket(pk:Object):void {
            var listeners:* = packet_listeners[pk.ID]
            if (listeners is Array)
                listeners.forEach(function(listener:Function, index:int, arr:Array):void {
                    listener(pk.Packet);
                });
        }

    }
}
