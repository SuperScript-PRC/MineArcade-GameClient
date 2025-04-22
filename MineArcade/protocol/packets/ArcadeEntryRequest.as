package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class ArcadeEntryRequest implements ClientPacket {
        public var ArcadeGameType:int;
        public var EntryID:String;
        public var RequestUUID:String;

        public function ArcadeEntryRequest(ArcadeGameType:int = undefined, EntryID:String = undefined, RequestUUID:String = undefined):void {
            this.ArcadeGameType = ArcadeGameType
            this.EntryID = EntryID
            this.RequestUUID = RequestUUID
        }

        public function ID():int {
            return Pool.IDArcadeEntryRequest
        }

        public function Marshal(w:ByteArray):void {
            w.writeByte(this.ArcadeGameType)
            w.writeUTF(this.EntryID)
            w.writeUTF(this.RequestUUID)
        }
    }
}
