package MineArcade.protocol.packets.arcade.plane_fighter {
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;

    public class PlaneFighterTimer implements ServerPacket {
        public var SecondsLeft:int;

        function PlaneFighterTimer(secondsLeft:int = undefined) {
            this.SecondsLeft = secondsLeft;
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterTimer;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.SecondsLeft = r.readInt();
        }
    }
}
