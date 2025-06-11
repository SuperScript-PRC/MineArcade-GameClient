package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class GamePlayer {
        public var Name:String;
        public var UUID:String;

        public function GamePlayer(Name:String = undefined, UUID:String = undefined):void {
            this.Name = Name
            this.UUID = UUID
        }

        public function Unmarshal(r:ByteArray):void {
            this.Name = r.readUTF();
            this.UUID = r.readUTF();
        }
    }
}