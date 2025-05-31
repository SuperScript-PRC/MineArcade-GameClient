package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.PacketNetType;

    public class ClientLogin implements ClientPacket {
        public var Username: String;
        public var Password: String;

        public function ClientLogin(Username:String=undefined, Password:String=undefined):void{
            this.Username = Username
            this.Password = Password
        }

        public function ID():int{
            return Pool.IDClientLogin
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Marshal(w:ByteArray):void{
            w.writeUTF(this.Username)
            w.writeUTF(this.Password)
        }
    }
}
