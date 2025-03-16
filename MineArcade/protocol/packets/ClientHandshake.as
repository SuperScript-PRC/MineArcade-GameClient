package MineArcade.protocol.packets
{
    import flash.utils.ByteArray;

    public class ClientHandshake implements ClientPacket {
        public var ClientVersion: int;

        public function ID():int{
            return Pool.IDClientHandshake
        }

        public function Marshal(r:ByteArray):void{
            r.writeInt(this.ClientVersion)
        }
    }
}