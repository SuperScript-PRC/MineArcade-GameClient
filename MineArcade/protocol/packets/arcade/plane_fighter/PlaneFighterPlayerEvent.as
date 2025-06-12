package MineArcade.protocol.packets.arcade.plane_fighter {
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import MineArcade.protocol.packets.ClientPacket;
    import flash.utils.ByteArray;
    import MineArcade.utils.Iota;

    public class PlaneFighterPlayerEvent implements ClientPacket {
        private static const iota:Function = new Iota().iota;
        public static const StartFire:int = iota();
	    public static const StopFire:int = iota();

        public var EventID:int;
        public var Value:int;

        function PlaneFighterPlayerEvent(eventID:int = undefined, value:int = undefined) {
            this.EventID = eventID;
            this.Value = value;
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterPlayerEvent;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Marshal(w:ByteArray):void {
            w.writeByte(this.EventID)
            w.writeInt(this.Value)
        }
    }
}
