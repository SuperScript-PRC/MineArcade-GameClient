package authentication {
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import utils.base64;
    import utils.md5;
    import protocol.packet_handler;
    import protocol.writer;
    import protocol.packet_ids;

    public class auth {
        private var socket:Socket;
        private var login_resp_cb:Function;
        private var hooked_packet_handler:packet_handler;
        private var hooked_packet_sender:writer;
        private const pkIDs: packet_ids = new packet_ids();

        public function HookPacketHandler(hdl:packet_handler):void {
            hooked_packet_handler = hdl;
        }
        public function HookPacketSender(snd:writer):void {
            hooked_packet_sender = snd;
        }

        public function Auth(username:String, password:String, login_resp_cb:Function):void {
            hooked_packet_handler.addPacketListener(pkIDs.IDClientLoginResp, function(pk:Object):void {
                login_resp_cb(pk.Success, pk.Message, pk.StatusCode)
            });
            hooked_packet_sender.ClientLogin(username, getBase64OfMD5(password + "minearc#01"));
        }

        private function getBase64OfMD5(input:String):String {
            var m: md5 = new md5(input);
            return base64.encode(m.str_md5())
        }
    }
}
