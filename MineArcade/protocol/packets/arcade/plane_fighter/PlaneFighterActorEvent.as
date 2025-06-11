package MineArcade.protocol.packets.arcade.plane_fighter {
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.PlaneFighterEvent;

    public class PlaneFighterActorEvent implements ServerPacket {
        public var Events:Array;

        function PlaneFighterActorEvent(events:Array = undefined) {
            this.Events = events;
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterActorEvent;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.Events = PacketReader.readArray(r, PlaneFighterEvent);
        }
    }
}
