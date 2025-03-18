package MineArcade.protocol.packets {
    import flash.net.Socket;

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

        public function Unmarshal(r:Socket):void {
            this.ArcadeGameType = r.readByte();
            this.ResponseUUID = r.readUTF();
            this.Success = r.readBoolean();
        }
    }
}
