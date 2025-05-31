package MineArcade.core {
    import flash.display.MovieClip;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.PacketWriter;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.user.UserData;
    import MineArcade.protocol.TCPConnection;
    import MineArcade.protocol.UDPConnection;

    public class CorArcade {
        public static const TCPAddress:String = "127.0.0.1";
        public static const UDPAddress:String = "127.0.0.1";
        public static const TCPPort:int = 6000;
        public static const UDPPort:int = 6001;
        private var tcp_conn:TCPConnection;
        private var udp_conn:UDPConnection;
        private var pk_handler:PacketHandler;
        private var pk_writer:PacketWriter;
        private var root:MovieClip = StageMC.root;
        private var userinfo:UserData;
        private var current_gametype:int = -1;

        public function CorArcade() {
            this.tcp_conn = new TCPConnection(TCPAddress, TCPPort);
            this.udp_conn = new UDPConnection(UDPAddress, UDPPort);
            this.pk_handler = new PacketHandler(this.tcp_conn, this.udp_conn);
            this.pk_writer = new PacketWriter();
            this.pk_writer.SetTCPSocket(this.tcp_conn.socket);
            this.pk_writer.SetUDPSocket(this.udp_conn.socket);
            this.tcp_conn.HookHandler(pk_handler);
            this.udp_conn.HookHandler(pk_handler);
            this.userinfo = new UserData(this);
        }

        public function getPacketHander():PacketHandler {
            return this.pk_handler;
        }

        public function getPacketWriter():PacketWriter {
            return this.pk_writer;
        }

        public function getTCPConnection():TCPConnection {
            return this.tcp_conn;
        }

        public function getUDPConnection():UDPConnection {
            return this.udp_conn;
        }

        public function getUserData():UserData {
            return this.userinfo;
        }

        public function SetCurrentGameType(gametype:int):void
        {
            this.current_gametype = gametype
        }

        public function GetCurrentGameType():int
        {
            return this.current_gametype
        }
    }
}
