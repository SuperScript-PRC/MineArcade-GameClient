package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;

    import MineArcade.protocol.packets.*;
    import MineArcade.protocol.packets.general.*;
    import MineArcade.protocol.packets.lobby.*;
    import MineArcade.protocol.packets.arcade.public_minearea.*;


    public class PacketReader {
        private var tcp_socket:Socket;
        private var udp_socket:*;

        function PacketReader(tcp_socket:Socket, udp_socket:*) {
            this.tcp_socket = tcp_socket;
            this.udp_socket = udp_socket;
        }

        public static function readArray(reader:ByteArray, unmarshaler:Function):Array {
            var arr:Array = [];
            var arr_length:int = reader.readInt();
            for (var i:Number = 0; i < arr_length; i++) {
                arr.push(unmarshaler(reader));
            }
            return arr;
        }

        public static function readBytes(reader:ByteArray):ByteArray {
            var buf:ByteArray = new ByteArray();
            var length:int = reader.readInt();
            reader.readBytes(buf, 0, length);
            return buf;
        }

        public function ReadTCPPacket():ServerPacket {
            var pk_size:int = this.tcp_socket.readInt();
            var buf:ByteArray = new ByteArray();
            this.tcp_socket.readBytes(buf, 0, pk_size)
            return this.DecodePacket(buf, pk_size);
        }

        public function ReadUDPPacket(buf:ByteArray):ServerPacket {
            var pk_size:int = buf.readInt();
            var pk_buf:ByteArray = new ByteArray();
            buf.readBytes(pk_buf, 0, pk_size)
            return this.DecodePacket(pk_buf, pk_size);
        }

        public function DecodePacket(buf:ByteArray, pk_size:int):ServerPacket {
            var pk:ServerPacket;
            var pkID:int = buf.readInt();
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
            pk.Unmarshal(buf);
            // trace("read: " + pkID + " = " + JSON.stringify(pk))
            return pk
        }
    }
}
