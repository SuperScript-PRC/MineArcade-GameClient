package MineArcade.core {
    import flash.display.MovieClip;
    import MineArcade.protocol.Connection;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.Writer;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.user.UserData;

    public class CorArcade {
        private var conn:Connection;
        private var pk_handler:PacketHandler;
        private var pk_writer:Writer;
        private var root:MovieClip = StageMC.root;
        private var userinfo:UserData;
        private var current_gametype:int = -1;

        public function CorArcade() {
            this.conn = new Connection("127.0.0.1", 6000);
            this.pk_handler = new PacketHandler(conn);
            this.pk_writer = new Writer(conn.socket);
            this.userinfo = new UserData(this);
            this.conn.hookHandler(pk_handler)
        }

        public function getPacketHander():PacketHandler {
            return this.pk_handler;
        }

        public function getPacketWriter():Writer {
            return this.pk_writer;
        }

        public function getConnection():Connection {
            return this.conn;
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
