package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    import MineArcade.protocol.packets.*;


    public class Reader {
        private var socket:Socket;
        private var buf:ByteArray = new ByteArray();

        public function Reader(sock:Socket) {
            socket = sock;
        }

        public static function readArray(reader:ByteArray, unmarshaler:Function):Array {
            var arr:Array = [];
            var arr_length:int = reader.readInt();
            for (var i:Number = 0; i < arr_length; i++) {
                arr.push(unmarshaler(reader));
            }
            return arr;
        }

        public function ReadPacket():ServerPacket {
            if (this.buf.bytesAvailable == 0)
                // 读完了内容, 进行 GC
                // TODO
                this.buf = new ByteArray()
            var pkID:int = this.socket.readInt();
            this.socket.readBytes(buf);
            var pk:ServerPacket;
            switch (pkID) {
                case Pool.IDServerHandshake:
                    pk = new ServerHandshake();
                case Pool.IDClientLoginResp:
                    pk = new ClientLoginResp();
                case Pool.IDKickClient:
                    pk = new KickClient();
                case Pool.IDDialLagResp:
                    pk = new DialLagResp();
                case Pool.IDPlayerBasics:
                    pk = new PlayerBasics();
                case Pool.IDBackpackResponse:
                    pk = new BackpackResponse();
                case Pool.IDSimpleEvent:
                    pk = new SimpleEvent();
                case Pool.IDPublicMineAreaChunk:
                    pk = new PublicMineAreaChunk();
                case Pool.IDPublicMineareaBlockEvent:
                    pk = new PublicMineareaBlockEvent();
                case Pool.IDPublicMineareaPlayerActorData:
                    pk = new PublicMineareaPlayerActorData();
                case Pool.IDArcadeEntryResponse:
                    pk = new ArcadeEntryResponse();
                default:
                    trace("[PacketHandler] Unknown packet ID: " + pkID);
                    return null;
            }
            pk.Unmarshal(this.buf);
            return pk
        }
    }
}
