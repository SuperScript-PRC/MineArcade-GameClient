package MineArcade.protocol.packets.arcade {
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.ptypes.ArcadeMatchPlayer;
    import MineArcade.utils.Iota;

    public class ArcadeMatchEvent implements ServerPacket {
        private static const iota:Function = new Iota().iota;
        public static const ArcadeMatchEventJoin:int = iota(0);
        public static const ArcadeMatchEventLeave:int = iota();
        public static const ArcadeMatchEventAccept:int = iota();
        public static const ArcadeMatchEventReady:int = iota();

        public var Action:int;
        public var Player:ArcadeMatchPlayer;

        function ArcadeMatchEvent(action:int = undefined, player:ArcadeMatchPlayer = undefined) {
            this.Action = action;
            this.Player = player;
        }

        public function ID():int {
            return PacketIDs.IDArcadeMatchEvent;
        }

        public function NetType():int {
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.Action = r.readByte();
            if (this.Action != ArcadeMatchEventReady) {
                this.Player = new ArcadeMatchPlayer();
                this.Player.Unmarshal(r);
            }
        }

        public function Marshal(w:ByteArray):void {
            w.writeByte(this.Action);
        }

    }
}
