package MineArcade.protocol.packets {
    import flash.net.Socket;

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

        public function Marshal(w:Socket):void{
            w.writeUTF(this.Username)
            w.writeUTF(this.Password)
        }
    }
}
