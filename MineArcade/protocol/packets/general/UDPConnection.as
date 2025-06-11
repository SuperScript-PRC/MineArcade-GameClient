package MineArcade.protocol.packets.general {
    import MineArcade.protocol.packets.ClientPacket;
    import flash.utils.ByteArray;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;

    public class UDPConnection implements ClientPacket {
        public var VerifyToken:String;

        function UDPConnection(VerifyToken:String=undefined){
            this.VerifyToken = VerifyToken;
        }

        public function ID():int {
            return PacketIDs.IDUDPConnection;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Marshal(w:ByteArray):void {
            w.writeUTF(this.VerifyToken)
        }
    }
}
