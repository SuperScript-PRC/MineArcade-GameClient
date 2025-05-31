package MineArcade.auth {
    import MineArcade.utils.base64;
    import MineArcade.utils.md5;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.general.ClientLogin;
    import MineArcade.protocol.packets.general.ClientLoginResp;
    import MineArcade.utils.LPromise;
    import MineArcade.protocol.PacketWriter;

    public class Authentication {
        private var login_resp_cb:Function;
        private var hooked_packet_handler:PacketHandler;
        private var hooked_packet_sender:PacketWriter;

        public function Authentication(cor:CorArcade) {
            hooked_packet_handler = cor.getPacketHander()
            hooked_packet_sender = cor.getPacketWriter();
        }

        /**
         * 登录 MineArcade 服务端。
         * @param username 用户名
         * @param password 密码 (Raw)
         * @return Promise<{success:Boolean, msg:String, status_code:int}>
         */
        public function Auth(username:String, password:String):LPromise {
            var pk:ClientLogin = new ClientLogin()
            pk.Username = username
            pk.Password = getBase64OfMD5(password + "minearc#01")
            hooked_packet_sender.WritePacket(pk);
            var p:LPromise = hooked_packet_handler.waitForPacket(Pool.IDClientLoginResp, 10000).then(function(cb:Function, pk:ClientLoginResp, ok:Boolean):void {
                if (ok)
                    cb(pk.Success, pk.Message, pk.StatusCode)
                else
                    cb(false, "登录超时", 404)
            })
            return p
        }

        private function getBase64OfMD5(input:String):String {
            var m:md5 = new md5(input);
            return base64.encode(m.str_md5())
        }
    }
}
