package MineArcade.protocol.ptypes
{
    import flash.utils.ByteArray;

    public class PlaneFighterStageActor{
        public var RuntimeID:int;
        public var CenterX:Number;
        public var CenterY:Number;

        public function Unmarshal(r:ByteArray):void {
            this.RuntimeID = r.readInt();
            this.CenterX = r.readFloat();
            this.CenterY = r.readFloat();
        }
    }
}