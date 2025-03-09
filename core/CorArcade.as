package core {
    import protocol.Connection;
    import protocol.PacketHandler;
    import protocol.Writer;
    import flash.display.MovieClip;
    import mcs_getter.StageMC;

    public class CorArcade {
        private var conn:Connection;
        private var pk_handler:PacketHandler;
        private var pk_writer:Writer;
        private var stage:MovieClip = StageMC.stage;

        public function CorArcade() {
            conn = new Connection("127.0.0.1", 6000);
            pk_handler = new PacketHandler(conn);
            pk_writer = new Writer(conn.socket);
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
    }
}
