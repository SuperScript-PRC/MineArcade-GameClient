package MineArcade.protocol.packets {
    import flash.net.Socket;
    import MineArcade.protocol.Reader;

    public class BackpackResponse implements ServerPacket{
        public var Items:Array;

        public function BackpackResponse(Items:Array=undefined):void {
            this.Items = Items
        }

        public function ID():int {
            return Pool.IDBackpackResponse
        }

        public function Unmarshal(r:Socket):void {
            this.Items = Reader.readArray(r, function(r:Socket):Item {
                var it:Item = new Item()
                it.Unmarshal(r)
                return it
            })
        }
    }
}

import flash.net.Socket;

class Item {
    public var ID:int;
    public var Amount:int;

    public function Unmarshal(r:Socket):void {
        this.ID = r.readInt();
        this.Amount = r.readInt();
    }
}
