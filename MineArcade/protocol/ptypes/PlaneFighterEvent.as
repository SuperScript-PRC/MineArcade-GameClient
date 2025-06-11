package MineArcade.protocol.ptypes {
    import flash.utils.ByteArray;
    import MineArcade.utils.Iota;

    public class PlaneFighterEvent {
        internal static const iota:Function = new Iota().iota;
        public static const EVENT_ADD_ENTITY:int = iota();
        public static const EVENT_REMOVE_ENTITY:int = iota();
        public static const EVENT_DIED:int = iota();
        public static const EVENT_TNT_EXPLODED:int = iota();

        public var EventID:int;
        public var EntityRuntimeID:int;

        public function Marshal(w:ByteArray):void {
            w.writeByte(this.EventID);
            w.writeInt(this.EntityRuntimeID);
        }
    }
}
