package MineArcade.auth {
    import flash.net.Socket;
    import MineArcade.utils.base64;
    import MineArcade.utils.md5;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.Writer;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.ClientLogin;
    import MineArcade.protocol.packets.ClientLoginResp;

    public class Authentication {
        private var socket:Socket;
        private var login_resp_cb:Function;
        private var hooked_packet_handler:PacketHandler;
        private var hooked_packet_sender:Writer;

        public function Authentication(cor:CorArcade) {
            hooked_packet_handler = cor.getPacketHander()
            hooked_packet_sender = cor.getPacketWriter();
        }

        public function Auth(username:String, password:String, login_resp_cb:Function):void {
            hooked_packet_handler.addPacketListenerOnce(Pool.IDClientLoginResp, function(pk:ClientLoginResp):void {
                login_resp_cb(pk.Success, pk.Message, pk.StatusCode)
            });
            var pk:ClientLogin = new ClientLogin()
            pk.Username = username
            pk.Password = getBase64OfMD5(password + "minearc#01")
            hooked_packet_sender.WritePacket(pk);
        }

        private function getBase64OfMD5(input:String):String {
            var m:md5 = new md5(input);
            return base64.encode(m.str_md5())
        }
    }
}
