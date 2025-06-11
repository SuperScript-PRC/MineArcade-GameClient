package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.PlaneFighterPlayerEntry;
    import MineArcade.protocol.packets.ServerPacket;

    public class PlaneFighterPlayerList implements ServerPacket
    {
        public var Entries:Array;

        public function PlaneFighterPlayerList(Entries:Array=undefined)
        {
            this.Entries = Entries;
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterPlayerList;
        }

        public function NetType():int {
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void {
            PacketReader.readArray(r, PlaneFighterPlayerEntry)
        }
    }
}