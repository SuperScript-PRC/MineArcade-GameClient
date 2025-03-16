package MineArcade.protocol.packets {
    import flash.utils.ByteArray;
    import MineArcade.protocol.Reader;

    public class BackpackResponse implements ServerPacket{
        public var Items:Array;

        public function ID():int {
            return Pool.IDBackpackResponse
        }

        public function Unmarshal(r:ByteArray):void {
            this.Items = Reader.readArray(r, function(r:ByteArray):Item {
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
