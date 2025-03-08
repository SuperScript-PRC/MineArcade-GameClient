package auth {
    import flash.net.Socket;
    import utils.base64;
    import utils.md5;
    import protocol.PacketHandler;
    import protocol.Writer;
    import protocol.PacketIDs;

    public class Authentication {
        private var socket:Socket;
        private var login_resp_cb:Function;
        private var hooked_packet_handler:PacketHandler;
        private var hooked_packet_sender:Writer;
        private const pkIDs:PacketIDs = new PacketIDs();

        public function HookPacketHandler(hdl:PacketHandler):void {
            hooked_packet_handler = hdl;
        }

        public function HookPacketSender(snd:Writer):void {
            hooked_packet_sender = snd;
        }

        public function Auth(username:String, password:String, login_resp_cb:Function):void {
            hooked_packet_handler.addPacketListener(PacketIDs.IDClientLoginResp, function(pk:Object):void {
                login_resp_cb(pk.Success, pk.Message, pk.StatusCode)
            });
            hooked_packet_sender.ClientLogin(username, getBase64OfMD5(password + "minearc#01"));
        }

        private function getBase64OfMD5(input:String):String {
            var m:md5 = new md5(input);
            return base64.encode(m.str_md5())
        }
    }
}
