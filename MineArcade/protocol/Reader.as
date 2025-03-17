package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    import MineArcade.protocol.packets.*;


    public class Reader {
        private var socket:Socket;

        public function Reader(sock:Socket) {
            socket = sock;
        }

        public static function readArray(reader:Socket, unmarshaler:Function):Array {
            var arr:Array = [];
            var arr_length:int = reader.readInt();
            for (var i:Number = 0; i < arr_length; i++) {
                arr.push(unmarshaler(reader));
            }
            return arr;
        }

        public function ReadPacket():ServerPacket {
            var pk:ServerPacket;
            var pkID:int = this.socket.readInt();
            switch (pkID) {
                case Pool.IDServerHandshake:
                    pk = new ServerHandshake();
                    break;
                case Pool.IDClientLoginResp:
                    pk = new ClientLoginResp();
                    break;
                case Pool.IDKickClient:
                    pk = new KickClient();
                    break;
                case Pool.IDDialLagResp:
                    pk = new DialLagResp();
                    break;
                case Pool.IDPlayerBasics:
                    pk = new PlayerBasics();
                    break;
                case Pool.IDBackpackResponse:
                    pk = new BackpackResponse();
                    break;
                case Pool.IDSimpleEvent:
                    pk = new SimpleEvent();
                    break;
                case Pool.IDPublicMineAreaChunk:
                    pk = new PublicMineAreaChunk();
                    break;
                case Pool.IDPublicMineareaBlockEvent:
                    pk = new PublicMineareaBlockEvent();
                    break;
                case Pool.IDPublicMineareaPlayerActorData:
                    pk = new PublicMineareaPlayerActorData();
                    break;
                case Pool.IDArcadeEntryResponse:
                    pk = new ArcadeEntryResponse();
                    break;
                default:
                    trace("[PacketHandler] Unknown packet ID: " + pkID);
                    return null;
            }
            pk.Unmarshal(this.socket);
            return pk
        }
    }
}
