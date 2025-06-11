package MineArcade.protocol.packets.lobby {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

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
            return PacketIDs.IDArcadeEntryRequest
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Marshal(w:ByteArray):void {
            w.writeByte(this.ArcadeGameType)
            w.writeUTF(this.EntryID)
            w.writeUTF(this.RequestUUID)
        }
    }
}
