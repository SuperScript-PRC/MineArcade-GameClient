package MineArcade.protocol.ptypes {
    import flash.utils.ByteArray;
    import MineArcade.utils.Iota;

    public class PlaneFighterEvent {
        internal static const iota:Function = new Iota().iota;
        public static const EVENT_ADD_ENTITY:int = iota(1); // deprecated
        public static const EVENT_REMOVE_ENTITY:int = iota();
        public static const EVENT_DIED:int = iota();
        public static const EVENT_TNT_EXPLODED:int = iota();
        public static const EVENT_COLORFUL_EXPLODE:int = iota();

        public var EventID:int;
        public var EntityRuntimeID:int;

        public function Unmarshal(r:ByteArray):void {
            this.EventID = r.readByte();
            this.EntityRuntimeID = r.readInt();
        }
    }
}
