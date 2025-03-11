package MineArcade.protocol {
    import flash.utils.ByteArray;
    import flash.net.Socket;


    public class Reader {
        private var socket:Socket;

        public function Reader(sock:Socket) {
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
            var pkID:int = this.socket.readInt();
            switch (pkID) {
                case PacketIDs.IDServerHandshake:
                    return {ID: PacketIDs.IDServerHandshake, Packet: ServerHandshake()}
                case PacketIDs.IDClientLoginResp:
                    return {ID: PacketIDs.IDClientLoginResp, Packet: ClientLoginResp()}
                case PacketIDs.IDKickClient:
                    return {ID: PacketIDs.IDKickClient, Packet: KickClient()}
                case PacketIDs.IDDialLagResp:
                    return {ID: PacketIDs.IDDialLagResp, Packet: DialLagResp()}
                case PacketIDs.IDPlayerBasics:
                    return {ID: PacketIDs.IDPlayerBasics, Packet: PlayerBasics()}
                case PacketIDs.IDBackpackResponse:
                    return {ID: PacketIDs.IDBackpackResponse, Packet: BackpackResponse()}
                case PacketIDs.IDSimpleEvent:
                    return {ID: PacketIDs.IDSimpleEvent, Packet: SimpleEvent()}
                default:
                    trace("[PacketHandler] Unknown packet ID: " + pkID);
                    return {ID: -1, Packet: null};
            }
        }

        // 数据包反序列化
        public function ServerHandshake():Object {
            var success:Boolean = socket.readBoolean();
            var server_version:int = socket.readInt();
            var server_message:String = socket.readUTF();
            return {Success: success,
                    ServerVersion: server_version,
                    ServerMessage: server_message}
        }

        public function ClientLoginResp():Object {
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
            var points:Number = socket.readInt();
            var level:Number = socket.readInt();
            var exp:Number = socket.readInt();
            var exp_upgrade:Number = socket.readInt();
            return {Nickname: nickname,
                    UUID: uuid,
                    Money: money,
                    Power: power,
                    Points:points,
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
