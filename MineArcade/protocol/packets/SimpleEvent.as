package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public class SimpleEvent implements ClientPacket, ServerPacket {
        public var EventType:int;
        public var EventData:int;

        public function SimpleEvent(EventType:int = undefined, EventData:int = undefined):void {
            this.EventType = EventType
            this.EventData = EventData
        }

        public function ID():int {
            return Pool.IDSimpleEvent
        }

        public function Unmarshal(r:ByteArray):void {
            this.EventType = r.readInt();
            this.EventData = r.readInt();
        }

        public function Marshal(w:ByteArray):void {
            w.writeInt(this.EventType);
            w.writeInt(this.EventData);
        }
    }
}
