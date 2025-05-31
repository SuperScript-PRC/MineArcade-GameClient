package MineArcade.protocol.packets.general {
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.PacketNetType;

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

        public function NetType(): int{
            return PacketNetType.TCP
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
