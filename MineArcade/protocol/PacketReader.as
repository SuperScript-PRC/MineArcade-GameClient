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
        private const server_packet_pool:Object = Pool.GetServerPool();

        function PacketReader(tcp_socket:Socket, udp_socket:*) {
            this.tcp_socket = tcp_socket;
            this.udp_socket = udp_socket;
        }

        /**
         * 读取一个 Array。
         * @param reader ByteArray
         * @param class_support_unmarshal 支持 Unmarshal 的类
         * @return Array.<Instance<class_support_unmarshal>>
         */
        public static function readArray(reader:ByteArray, class_support_unmarshal:Class):Array {
            var arr:Array = [];
            var arr_length:int = reader.readInt();
            for (var i:Number = 0; i < arr_length; i++) {
                var o:Object = new class_support_unmarshal();
                o.Unmarshal(reader);
                arr.push(o);
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
            var pkID:int = buf.readInt();
            var pk_cls:Class = server_packet_pool[pkID];
            if (pk_cls == null) {
                trace("[Error] Unknown packet ID: " + pkID)
                return null;
            }
            var pk:ServerPacket = new pk_cls();
            pk.Unmarshal(buf);
            trace("read: " + pkID + " = " + JSON.stringify(pk))
            return pk;
        }
    }
}
