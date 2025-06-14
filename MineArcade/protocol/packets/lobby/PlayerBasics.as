package MineArcade.protocol.packets.lobby {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class PlayerBasics implements ServerPacket {
        public var Nickname:String;
        public var UID:String;
        public var Money:Number;
        public var Power:int;
        public var Points:int;
        public var Level:int;
        public var Exp:int;
        public var ExpUpgrade:int;

        public function PlayerBasics(Nickname:String = undefined, UID:String = undefined, Money:Number = undefined, Power:int = undefined, Points:int = undefined, Level:int = undefined, Exp:int = undefined, ExpUpgrade:int = undefined):void {
            this.Nickname = Nickname
            this.UID = UID
            this.Money = Money
            this.Power = Power
            this.Points = Points
        }

        public function ID():int {
            return PacketIDs.IDPlayerBasics
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            this.Nickname = r.readUTF();
            this.UID = r.readUTF();
            this.Money = r.readDouble();
            this.Power = r.readInt();
            this.Points = r.readInt();
            this.Level = r.readInt();
            this.Exp = r.readInt();
            this.ExpUpgrade = r.readInt();
        }
    }
}
