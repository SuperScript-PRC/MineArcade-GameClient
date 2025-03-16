package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class ClientLoginResp implements ServerPacket {
        public var Success:Boolean;
        public var Message:String;
        public var StatusCode:int;

        public function ID():int{
            return Pool.IDClientLoginResp
        }

        public function Unmarshal(r:ByteArray):void{
            Success = r.readBoolean()
            Message = r.readUTF()
            StatusCode = r.readInt()
        }
    }
}