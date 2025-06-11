package MineArcade.protocol.packets.arcade
{
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;

    public class ArcadeExitGame implements ClientPacket{
        function ArcadeExitGame(){
        }
        
        public function ID():int
        {
            return PacketIDs.IDArcadeExitGame;
        }

        public function NetType():int
        {
            return PacketNetType.TCP;
        }

        public function Marshal(w:ByteArray):void{
        }
    }
}