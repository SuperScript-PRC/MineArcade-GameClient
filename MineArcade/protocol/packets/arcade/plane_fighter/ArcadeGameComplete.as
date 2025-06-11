package MineArcade.protocol.packets.arcade.plane_fighter {
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;

    public class ArcadeGameComplete implements ServerPacket {
        public var TotalScore:int;

        function ArcadeGameComplete(TotalScore:int = undefined) {
            this.TotalScore = TotalScore;
        }

        public function ID():int {
            return PacketIDs.IDArcadeGameComplete;
        }

        public function NetType():int {
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.TotalScore = r.readInt();
        }
    }
}
