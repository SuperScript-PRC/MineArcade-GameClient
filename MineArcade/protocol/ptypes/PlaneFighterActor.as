package MineArcade.protocol.ptypes {

    import flash.utils.ByteArray;

    public class PlaneFighterActor {
        public var ActorType:int;
        public var RuntimeID:int;
        public var X:Number;
        public var Y:Number;

        function PlaneFighterActor(ActorType:int = undefined, RuntimeID:int = undefined, X:Number = undefined, Y:Number = undefined):void {
            this.ActorType = ActorType
            this.RuntimeID = RuntimeID
            this.X = X
            this.Y = Y
        }

        public function Unmarshal(r:ByteArray):void {
            this.ActorType = r.readByte();
            this.RuntimeID = r.readInt();
            this.X = r.readFloat();
            this.Y = r.readFloat();
        }
    }
}
