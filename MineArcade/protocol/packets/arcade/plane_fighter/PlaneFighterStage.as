package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.PlaneFighterStageActor;
    import flash.utils.ByteArray;

    public class PlaneFighterStage implements ServerPacket {
        public var Players:Array;
        public var Entities:Array;

        function PlaneFighterStage(Players:Array = undefined, Entities:Array = undefined){
            this.Players = Players;
            this.Entities = Entities;
        }

        public function ID():int
        {
            return PacketIDs.IDPlaneFighterStage;
        }

        public function NetType():int{
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Players = PacketReader.readArray(r, PlaneFighterStageActor);
            this.Entities = PacketReader.readArray(r, PlaneFighterStageActor);
        }
    }
}