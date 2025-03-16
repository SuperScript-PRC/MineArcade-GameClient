package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class PlayerBasics implements ServerPacket {
        public var Nickname:String;
        public var UUID:String;
        public var Money:Number;
        public var Power:int;
        public var Points:int;
        public var Level:int;
        public var Exp:int;
        public var ExpUpgrade:int;

        public function ID():int{
            return Pool.IDPlayerBasics
        }

        public function Unmarshal(r:ByteArray):void{
            this.Nickname = r.readUTF();
            this.UUID = r.readUTF();
            this.Money = r.readDouble();
            this.Power = r.readInt();
            this.Points = r.readInt();
            this.Level = r.readInt();
            this.Exp = r.readInt();
            this.ExpUpgrade = r.readInt();
        }
    }
}
