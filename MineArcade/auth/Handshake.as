package MineArcade.auth {
    import flash.utils.setTimeout;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.PacketWriter;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.general.ClientHandshake;
    import MineArcade.utils.LPromise;

    public class Handshake {
        private var login_resp_cb:Function;
        private var hooked_packet_listener:PacketHandler;
        private var hooked_packet_sender:PacketWriter;
        private const HANDSHAKE_TIMEOUT_TIME:int = 5000;

        public function Handshake(pkt_sender:PacketWriter, pkt_listener:PacketHandler):void {
            hooked_packet_listener = pkt_listener;
            hooked_packet_sender = pkt_sender;
        }

        /**
         * 发送 Handshake 并等待 MineArcade 服务端响应。
         * @return 收到 ServerHandshake 后的回调: Promise<pk:ServerHandshake, ok:Boolean>
         */
        public function sendHandshake():LPromise {
            var pk:ClientHandshake = new ClientHandshake()
            pk.ClientVersion = define.CLIENT_VERSION
            hooked_packet_sender.WritePacket(pk);
            return hooked_packet_listener.waitForPacket(PacketIDs.IDServerHandshake, HANDSHAKE_TIMEOUT_TIME)
        }
    }
}
