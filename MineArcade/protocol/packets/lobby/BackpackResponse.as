package MineArcade.protocol.packets.lobby {
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class BackpackResponse implements ServerPacket{
        public var Items:Array;

        public function BackpackResponse(Items:Array=undefined):void {
            this.Items = Items
        }

        public function ID():int {
            return PacketIDs.IDBackpackResponse
        }

        public function NetType(): int{
            return PacketNetType.TCP
        }

        public function Unmarshal(r:ByteArray):void {
            this.Items = PacketReader.readArray(r, Item)
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
