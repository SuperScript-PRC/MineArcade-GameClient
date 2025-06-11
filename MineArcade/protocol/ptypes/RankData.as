package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class RankData {
        public var PlayerName:String;
        public var PlayerUUID:String;
        public var Score:int;
        public var Rank:uint;

        public function RankData(PlayerName:String = undefined, PlayerUUID:String = undefined, Score:int = undefined, Rank:uint = undefined) {
            this.PlayerName = PlayerName;
            this.PlayerUUID = PlayerUUID;
            this.Score = Score;
            this.Rank = Rank;
        }

        public function Unmarshal(r:ByteArray):void {
            this.PlayerName = r.readUTF();
            this.PlayerUUID = r.readUTF();
            this.Score = r.readInt();
            this.Rank = r.readUnsignedInt();
        }
    }
}