package MineArcade.protocol {

    import flash.utils.setTimeout;

    public class PacketHandler extends Reader {
        private var packet_listeners:Object = {};

        public function PacketHandler(conn:Connection) {
            super(conn.socket);
        }

        public function addPacketListener(pkID:int, listener:Function):void {
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                listeners = [];
            if (listeners is Array) {
                listeners.push(listener);
                packet_listeners[pkID] = listeners;
            }
        }

        public function removePacketListener(pkID:int, listener:Function):void {
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                return;
            for (var i:int = 0; i < listeners.length; i++) {
                if (listeners[i] == listener) {
                    listeners.splice(i, 1);
                    if (listeners.length == 0) {
                        delete packet_listeners[pkID];
                    }
                    break;
                }
            }
        }

        public function addPacketListenerOnce(pkID:int, listener:Function):void {
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

        public function addPacketListenerOnceWithTimeout(pkID:int, listener:Function, timeout:int, timeout_cb:Function):void {
            var listeners:* = packet_listeners[pkID]
            var ok:Boolean = false;
            if (listeners == undefined)
                listeners = [];
            var fnc:Function = function(packet:Object):void {
                listener(packet);
                removePacketListener(pkID, fnc);
                ok = true;
            }
            listeners.push(fnc);
            packet_listeners[pkID] = listeners;
            setTimeout(function():void {
                if (!ok) {
                    timeout_cb();
                    removePacketListener(pkID, fnc);
                }
            }, timeout)
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
