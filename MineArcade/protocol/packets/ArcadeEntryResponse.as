package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class ArcadeEntryResponse implements ServerPacket{
        public var ArcadeGameType:int;
        public var ResponseUUID:String;
        public var Success:Boolean;

        public function ID():int{
            return Pool.IDArcadeEntryResponse
        }

        public function Unmarshal(r:ByteArray):void{
            this.ArcadeGameType = r.readInt();
            this.ResponseUUID = r.readUTF();
            this.Success = r.readBoolean();
        }
    }
}