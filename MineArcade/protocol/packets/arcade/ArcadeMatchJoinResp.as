package MineArcade.protocol.packets.arcade
{
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.protocol.ptypes.ArcadeMatchPlayer;

    public class ArcadeMatchJoinResp implements ServerPacket{
        public var Success:Boolean;
        public var Message:String;
        public var CurrentPlayers:Array;

        function ArcadeMatchJoinResp(success:Boolean = undefined, message:String=undefined, currentPlayers:Array = undefined){
            this.Success = success;
            this.Message = message;
            this.CurrentPlayers = currentPlayers;
        }
        
        public function ID():int
        {
            return PacketIDs.IDArcadeMatchJoinResp;
        }

        public function NetType():int
        {
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void{
            this.Success = r.readBoolean();
            this.Message = r.readUTF();
            this.CurrentPlayers = PacketReader.readArray(r, ArcadeMatchPlayer)
        }
    }
}