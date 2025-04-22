package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class PublicMineareaPlayerActorData implements ClientPacket, ServerPacket {
        public var Nickname:String;
        public var UUIDStr:String;
        public var X:Number;
        public var Y:Number;
        public var Action:int;

        public function PublicMineareaPlayerActorData(Nickname:String = undefined, UUIDStr:String = undefined, X:Number = undefined, Y:Number = undefined, Action:int = undefined):void {
            this.Nickname = Nickname
            this.UUIDStr = UUIDStr
            this.X = X
            this.Y = Y
            this.Action = Action
        }

        public function ID():int {
            return Pool.IDPublicMineareaPlayerActorData
        }

        public function Unmarshal(r:ByteArray):void {
            this.Nickname = r.readUTF();
            this.UUIDStr = r.readUTF();
            this.X = r.readDouble();
            this.Y = r.readDouble();
            this.Action = r.readByte();
        }

        public function Marshal(w:ByteArray):void {
            w.writeUTF(this.Nickname)
            w.writeUTF(this.UUIDStr);
            w.writeDouble(this.X);
            w.writeDouble(this.Y);
            w.writeByte(this.Action);
        }
    }
}
