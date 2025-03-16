package MineArcade.auth {
    import flash.utils.setTimeout;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.Writer;
    import MineArcade.protocol.packets.ClientHandshake;
    import MineArcade.protocol.packets.Pool;

    public class Handshake {
        private var login_resp_cb:Function;
        private var hooked_packet_listener:PacketHandler;
        private var hooked_packet_sender:Writer;
        private const HANDSHAKE_TIMEOUT_TIME:int = 5000;

        public function Handshake(pkt_sender:Writer, pkt_listener:PacketHandler):void {
            hooked_packet_listener = pkt_listener;
            hooked_packet_sender = pkt_sender;
        }

        public function sendHandshake(cb:Function):void {
            var pk:ClientHandshake = new ClientHandshake()
            pk.ClientVersion = define.CLIENT_VERSION
            hooked_packet_sender.WritePacket(pk);
            var getting:Boolean = false
            hooked_packet_listener.addPacketListenerOnce(Pool.IDServerHandshake, function(packet:Object):void {
                getting = true
                cb(packet.Success, packet.ServerMessage)
            })
            setTimeout(function():void {
                if (!getting) {
                    cb(false, "服务端连接超时");
                }
            }, HANDSHAKE_TIMEOUT_TIME)
        }
    }
}
