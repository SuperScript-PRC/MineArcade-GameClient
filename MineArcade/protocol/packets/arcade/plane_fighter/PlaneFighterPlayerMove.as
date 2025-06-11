package MineArcade.protocol.packets.arcade.plane_fighter
{
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;

    public class PlaneFighterPlayerMove implements ClientPacket {
        public var X:Number;
        public var Y:Number;

        function PlaneFighterPlayerMove(x:Number = undefined, y:Number = undefined) {
            this.X = x;
            this.Y = y;
        }

        public function ID():int{
            return PacketIDs.IDPlaneFighterPlayerMove;
        }

        public function NetType():int{
            return PacketNetType.UDP;
        }

        public function Marshal(w:ByteArray):void{
            w.writeFloat(this.X)
            w.writeFloat(this.Y)
        }
    }
}