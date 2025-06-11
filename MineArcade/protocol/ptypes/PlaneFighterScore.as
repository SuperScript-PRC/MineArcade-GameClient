package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class PlaneFighterScore{
        public var PlayerRuntimeID: int;
        public var AddScore: int;
        public var TotalScore: int;

        function PlaneFighterScore(PlayerRuntimeID: int=undefined, AddScore: int=undefined, TotalScore: int=undefined):void {
            this.PlayerRuntimeID = PlayerRuntimeID;
            this.AddScore = AddScore;
            this.TotalScore = TotalScore;
        }

        public function Unmarshal(r:ByteArray):void{
            this.PlayerRuntimeID = r.readInt();
            this.AddScore = r.readInt();
            this.TotalScore = r.readInt();
        }
    }
}