package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.PFPlayerStatus;

    public class PlaneFighterPlayerStatuses implements ServerPacket{
        public var Statuses:Array;

        public function PlaneFighterPlayerStatuses(statuses:Array=undefined)
        {
            this.Statuses = statuses;
        }

        public function ID():int{
            return PacketIDs.IDPlaneFighterPlayerStatuses;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Statuses = PacketReader.readArray(r, PFPlayerStatus);
        }
    }
}