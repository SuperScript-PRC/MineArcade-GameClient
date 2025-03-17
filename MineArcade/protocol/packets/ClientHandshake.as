package MineArcade.protocol.packets
{
    import flash.net.Socket;

    public class ClientHandshake implements ClientPacket {
        public var ClientVersion: int;

        public function ClientHandshake(ClientVersion:int=undefined):void{
            this.ClientVersion = ClientVersion
        }

        public function ID():int{
            return Pool.IDClientHandshake
        }

        public function Marshal(r:Socket):void{
            r.writeInt(this.ClientVersion)
        }
    }
}