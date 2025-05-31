package MineArcade.protocol.packets.arcade {

    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.PacketNetType;

    public class StartGame implements ClientPacket {
        public var ArcadeGameType: int
        public var EntryID: String

        public function StartGame(ArcadeGameType: int = undefined, EntryID: String = undefined): void {
            this.ArcadeGameType = ArcadeGameType
            this.EntryID = EntryID
        }

        public function ID(): int {
            return Pool.IDStartGame
        }

        public function NetType(): int {
            return PacketNetType.TCP
        }

        public function Marshal(w: ByteArray): void {
            w.writeByte(this.ArcadeGameType)
            w.writeUTF(this.EntryID)
        }
    }
}
