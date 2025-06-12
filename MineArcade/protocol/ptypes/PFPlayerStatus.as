package MineArcade.protocol.ptypes {

    import flash.utils.ByteArray;

    public class PFPlayerStatus {
        public var RuntimeID:int;
        public var HP:int;
        public var Bullets:int;

         function PFPlayerStatus(RuntimeID:int=undefined, HP:int=undefined, Bullets:int=undefined) {
            this.RuntimeID = RuntimeID;
            this.HP = HP;
            this.Bullets = Bullets;
        }

        public function Unmarshal(r:ByteArray):void {
            this.RuntimeID = r.readInt();
            this.HP = r.readInt();
            this.Bullets = r.readInt();
        }
    }
}
