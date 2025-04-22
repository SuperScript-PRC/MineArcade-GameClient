package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class ClientHandshake implements ClientPacket {
        public var ClientVersion: int;

        public function ClientHandshake(ClientVersion:int=undefined):void{
            this.ClientVersion = ClientVersion
        }

        public function ID():int{
            return Pool.IDClientHandshake
        }

        public function Marshal(w:ByteArray):void{
            w.writeInt(this.ClientVersion)
        }
    }
}