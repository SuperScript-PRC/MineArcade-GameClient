package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class ArcadeMatchPlayer{
        public var Username:String;
        public var Nickname:String;
        public var UUID:String;

        public function ArcadeMatchPlayer(username:String = undefined, nickname:String = undefined, uuid:String = undefined) {
            this.Username = username;
            this.Nickname = nickname;
            this.UUID = uuid;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Username = r.readUTF();
            this.Nickname = r.readUTF();
            this.UUID = r.readUTF();
        }
    }
}