package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.PlaneFighterScore;
    import MineArcade.protocol.packets.ServerPacket;

    public class PlaneFighterScores implements ServerPacket
    {
        public var Scores:Array;

        function PlaneFighterScores(Scores:Array=undefined):void {
            this.Scores = Scores
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterScores;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Scores = PacketReader.readArray(r, PlaneFighterScore)
        }
    }
}