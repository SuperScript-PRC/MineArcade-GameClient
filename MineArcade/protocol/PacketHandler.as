/**
 * MineArcade - PacketHandler
 */
package MineArcade.protocol {

    import flash.utils.setTimeout;
    import flash.display.MovieClip;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.utils.LPromise;
    import flash.utils.clearTimeout;

    public class PacketHandler extends PacketReader {
        private var packet_listeners:Object = {};

        function PacketHandler(tcp_conn:TCPConnection, udp_conn:UDPConnection) {
            super(tcp_conn.socket, udp_conn.socket);
        }

        /**
         * 添加一个数据包监听回调。
         * @param pkID 数据包 ID
         * @param listener 监听回调 (pk:ServerPacket)
         */
        public function addPacketListener(pkID:int, listener:Function):void {
            if (listener == null)
                throw new Error("listener is null");
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                // trace("addlistener for " + pkID)
                listeners = [];
            if (listeners is Array) {
                listeners.push(listener);
                packet_listeners[pkID] = listeners;
            }
        }

        /**
         * 添加一个绑定影片剪辑的数据包监听回调，影片剪辑被从场上移除时，在下一次监听时无效且移除监听器。
         * @param mc 影片剪辑
         * @param pkID 数据包 ID
         * @param listener 监听回调
         */
        public function addPacketListenerBoundingMC(mc:MovieClip, pkID:int, listener:Function):void {
            if (listener == null)
                throw new Error("listener is null");
            function _listener(packet:Object):void {
                if (mc.root == null) {
                    removePacketListener(pkID, _listener);
                    return;
                }
                listener(packet);
            }
            addPacketListener(pkID, _listener)
        }

        /**
         * 移除数据包监听回调
         * @param pkID 数据包 ID
         * @param listener 监听回调
         * @return 是否移除成功
         */
        public function removePacketListener(pkID:int, listener:Function):Boolean {
            // trace("removelistener for " + pkID)
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                return false;
            for (var i:int = 0; i < listeners.length; i++) {
                if (listeners[i] == listener) {
                    listeners.splice(i, 1);
                    if (listeners.length == 0) {
                        delete packet_listeners[pkID];
                    }
                    return true
                }
            }
            // trace(listeners)
            return false
        }

        /**
         * 添加一个仅监听一次的数据包监听器。
         * @param pkID 数据包 ID
         * @param listener 监听回调
         */
        public function addPacketListenerOnce(pkID:int, listener:Function):void {
            var listeners:* = packet_listeners[pkID]
            if (listeners == undefined)
                listeners = [];
            var fnc:Function = function(packet:ServerPacket):void {
                listener(packet);
                removePacketListener(pkID, fnc);
            }
            listeners.push(fnc);
            packet_listeners[pkID] = listeners;
        }

        /**
         * 有条件地监听一次数据包。如果回调返回了 true，则不再继续监听。建议使用 waitForPacket() 代替此方法。
         * @param pkID 数据包 ID
         * @param listener 回调函数
         * @param timeout 超时时间 (与 setTimeout 相同)
         * @param timeout_cb 超时时执行的回调
         */
        public function addPacketListenerOnceWithCondition(pkID:int, listener:Function, timeout:int = -1, timeout_cb:* = undefined):void {
            var listeners:* = packet_listeners[pkID]
            var ok:Boolean = false;
            if (listeners == undefined)
                listeners = [];
            var fnc:Function = function(packet:ServerPacket):void {
                var res:Boolean = listener(packet);
                if (res) {
                    removePacketListener(pkID, fnc);
                    ok = true;
                }
            }
            listeners.push(fnc);
            packet_listeners[pkID] = listeners;
            if (timeout > 0 && timeout_cb != undefined) {
                const tid:int = setTimeout(function():void {
                    if (!ok) {
                        timeout_cb();
                        removePacketListener(pkID, fnc);
                        clearTimeout(tid);
                    }
                }, timeout)
            }
        }

        public function handlePacket(pk:ServerPacket):void {
            var pkID:int = pk.ID()
            var listeners:Array = packet_listeners[pkID]
            if (listeners is Array) {
                listeners.forEach(function(listener:Function, index:int, arr:Array):void {
                    if (!(listener is Function)) {
                        trace("Warning: packet listener " + listener + " is not a function")
                    } else {
                        listener(pk);
                    }
                })
            } else
                trace("[Warning] No handler to handle packet ID=" + pkID)
        }

        /**
         * 等待数据包。
         * @param pkID 数据包 ID
         * @param delay 与 setTimeout() 一样的 delay 参数
         * @return LPromise.<pk:ServerPacket, ok:Boolean>, 如果没有 timeout 则 ok 为 true，否则为 false
         */
        public function waitForPacket(pkID:int, delay:Number):LPromise {
            return new LPromise(function(setter:Function):void {
                const listener:Function = function(pk:ServerPacket):void {
                    clearTimeout(tid)
                    removePacketListener(pkID, listener)
                    setter(pk, true)
                }
                const tid:uint = setTimeout(function():void {
                    removePacketListener(pkID, listener)
                    setter(null, false)
                    clearTimeout(tid)
                }, delay)
                addPacketListener(pkID, listener)
            })
        }

    }
}
