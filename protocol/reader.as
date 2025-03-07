package protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;
    import protocol.packet_ids


    public class reader {
        private var socket:Socket;
        private var pkIDs:packet_ids = new packet_ids()

        public function reader(sock:Socket) {
            socket = sock;
        }

        private function readArray(unmarshaler:Function):Array {
            var arr:Array = [];
            var arr_length:int = socket.readInt();
            for (var i:Number = 0; i < arr_length; i++) {
                arr.push(unmarshaler());
            }
            return arr;
        }

        public function ReadPacket():Object {
            var buf:ByteArray = new ByteArray();
            socket.readBytes(buf);
            var pkID:int = buf.readByte() << 2 | buf.readByte();
            switch (pkID) {
                case pkIDs.IDClientLoginResp:
                    return {ID: pkIDs.IDClientLoginResp, Packet: LoginResp()}
                case pkIDs.IDKickClient:
                    return {ID: pkIDs.IDKickClient, Packet: KickClient()}
                case pkIDs.IDDialLagResp:
                    return {ID: pkIDs.IDDialLagResp, Packet: DialLagResp()}
                case pkIDs.IDPlayerBasics:
                    return {ID: pkIDs.IDPlayerBasics, Packet: PlayerBasics()}
                case pkIDs.IDBackpackResponse:
                    return {ID: pkIDs.IDBackpackResponse, Packet: BackpackResponse()}
                case pkIDs.IDSimpleEvent:
                    return {ID: pkIDs.IDSimpleEvent, Packet: SimpleEvent()}
                default:
                    trace("[PacketHandler] Unknown packet ID: " + pkID);
                    return {ID: -1};
            }
        }

        // 数据包反序列化
        public function LoginResp():Object {
            var success:Boolean = socket.readBoolean();
            var message:String = socket.readUTF();
            var status_code:Number = socket.readByte();
            return {Success: success,
                    Message: message,
                    StatusCode: status_code}
        }

        public function KickClient():Object {
            var message:String = socket.readUTF();
            var status_code:Number = socket.readByte();
            return {Message: message,
                    StatusCode: status_code}
        }

        public function DialLagResp():Object {
            var dialUUID:String = socket.readUTF();
            return {DialUUID: dialUUID}
        }

        public function PlayerBasics():Object {
            var nickname:String = socket.readUTF();
            var uuid:String = socket.readUTF();
            var money:Number = socket.readDouble();
            var power:Number = socket.readInt();
            var level:Number = socket.readInt();
            var exp:Number = socket.readInt();
            var exp_upgrade:Number = socket.readInt();
            return {Nickname: nickname,
                    UUID: uuid,
                    Money: money,
                    Power: power,
                    Level: level,
                    Exp: exp,
                    ExpUpgrade: exp_upgrade}
        }

        public function BackpackResponse():Object {
            var items:Array = readArray(function():Object {
                var id:Number = socket.readInt();
                var amount:Number = socket.readInt();
                return {ID: id,
                        Amount: amount}
            });
            return {Items: items}
        }

        public function SimpleEvent():Object {
            var event_type:Number = socket.readInt();
            var event_data:Number = socket.readInt();
            return {EventType: event_type,
                    EventData: event_data}
        }
    }
}
