package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class PlaneFighterPlayerEntry{
        public var Name:String;
        public var UID:String;
        public var RuntimeID:int;

        function PlaneFighterPlayerEntry(name:String=undefined, uid:String=undefined, runtimeId:int=undefined) {
            this.Name = name;
            this.UID = uid;
            this.RuntimeID = runtimeId;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Name = r.readUTF();
            this.UID = r.readUTF();
            this.RuntimeID = r.readInt();
        }
    }
}