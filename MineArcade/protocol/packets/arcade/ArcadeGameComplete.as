package MineArcade.protocol.packets.arcade
{
    import MineArcade.protocol.ptypes.ArcadeGameScoreDetail;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.packets.ServerPacket;

    public class ArcadeGameComplete implements ServerPacket {
        public var Win:Boolean;
        public var TotalScore:int;
        public var ScoreDetails:Array;

        function ArcadeGameComplete(Win:Boolean = undefined, TotalScore:int = undefined,ScoreDetails:Array = undefined) {
            this.Win = Win;
            this.TotalScore = TotalScore;
            this.ScoreDetails = ScoreDetails;
        }

        public function ID():int {
            return PacketIDs.IDArcadeGameComplete;
        }

        public function NetType():int {
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.Win = r.readByte() != 0;
            this.TotalScore = r.readInt();
            this.ScoreDetails = PacketReader.readArray(r, ArcadeGameScoreDetail)
        }
    }
}