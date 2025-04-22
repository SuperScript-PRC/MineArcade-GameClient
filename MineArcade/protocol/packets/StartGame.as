package MineArcade.protocol.packets {

    import flash.utils.ByteArray;

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

        public function Marshal(w: ByteArray): void {
            w.writeByte(this.ArcadeGameType)
            w.writeUTF(this.EntryID)
        }
    }
}
