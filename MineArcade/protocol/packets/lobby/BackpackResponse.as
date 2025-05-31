package MineArcade.protocol.packets.lobby {
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.protocol.packets.PacketNetType;

    public class BackpackResponse implements ServerPacket{
        public var Items:Array;

        public function BackpackResponse(Items:Array=undefined):void {
            this.Items = Items
        }

        public function ID():int {
            return Pool.IDBackpackResponse
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            this.Items = PacketReader.readArray(r, function(r:ByteArray):Item {
                var it:Item = new Item()
                it.Unmarshal(r)
                return it
            })
        }
    }
}

import flash.utils.ByteArray;

class Item {
    public var ID:int;
    public var Amount:int;

    public function Unmarshal(r:ByteArray):void {
        this.ID = r.readInt();
        this.Amount = r.readInt();
    }
}
