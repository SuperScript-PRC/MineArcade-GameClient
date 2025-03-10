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

        public function CorArcade() {
            conn = new Connection("127.0.0.1", 6000);
            pk_handler = new PacketHandler(conn);
            pk_writer = new Writer(conn.socket);
            userinfo = new UserData(this);
            conn.hookHandler(pk_handler)
        }

        public function getPacketHander():PacketHandler {
            return pk_handler;
        }

        public function getPacketWriter():Writer {
            return pk_writer;
        }

        public function getConnection():Connection {
            return conn;
        }

        public function getUserData():UserData {
            return userinfo;
        }
    }
}
