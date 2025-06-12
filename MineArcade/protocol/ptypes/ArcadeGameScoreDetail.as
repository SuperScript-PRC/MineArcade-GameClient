package MineArcade.protocol.ptypes {
    import flash.utils.ByteArray;

    public class ArcadeGameScoreDetail {
        public var ScoreID:int;
        public var Score:int;

        function ArcadeGameScoreDetail(ScoreID:int = undefined, Score:int = undefined) {
            this.ScoreID = ScoreID;
            this.Score = Score;
        }

        public function Unmarshal(r:ByteArray):void {
            this.ScoreID = r.readByte();
            this.Score = r.readInt();
        }
    }
}
