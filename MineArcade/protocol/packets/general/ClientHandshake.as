package MineArcade.protocol.packets.general
{
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.PacketNetType;
    

    public class ClientHandshake implements ClientPacket {
        public var ClientVersion: int;

        public function ClientHandshake(ClientVersion:int=undefined):void{
            this.ClientVersion = ClientVersion
        }

        public function ID():int{
            return Pool.IDClientHandshake
        }

        public function NetType():int{
            return PacketNetType.TCP
        }

        public function Marshal(w:ByteArray):void{
            w.writeInt(this.ClientVersion)
        }
    }
}