package MineArcade.protocol.packets.lobby {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketNetType;

    public class ArcadeEntryResponse implements ServerPacket {
        public var ArcadeGameType:int;
        public var ResponseUUID:String;
        public var Success:Boolean;

        public function ArcadeEntryResponse(ArcadeGameType:int = undefined, ResponseUUID:String = undefined, Success:Boolean = undefined):void {
            this.ArcadeGameType = ArcadeGameType
            this.ResponseUUID = ResponseUUID
            this.Success = Success
        }

        public function ID():int {
            return Pool.IDArcadeEntryResponse
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            this.ArcadeGameType = r.readByte();
            this.ResponseUUID = r.readUTF();
            this.Success = r.readBoolean();
        }
    }
}
