package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.ptypes.PlaneFighterActor;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;

    public class PlaneFighterAddActor implements ServerPacket {
        public var Actors:Array;

        function PlaneFighterAddActor(Actor:Array = undefined){
            this.Actors = Actors;
        }

        public function ID():int
        {
            return PacketIDs.IDPlaneFighterAddActor;
        }

        public function NetType():int
        {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Actors = PacketReader.readArray(r, PlaneFighterActor)
        }
    }
}