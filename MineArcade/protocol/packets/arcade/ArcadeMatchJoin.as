package MineArcade.protocol.packets.arcade
{
    import MineArcade.protocol.packets.ClientPacket;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;

    public class ArcadeMatchJoin implements ClientPacket{
        public var ArcadeGameType:int;
        public var GameMode:int;
        public var RoomID:int;

        function ArcadeMatchJoin(arcadeGameType:int = undefined, gameMode:int=undefined,roomID:int = undefined){
            this.ArcadeGameType = arcadeGameType;
            this.GameMode = gameMode;
            this.RoomID = roomID;
        }

        public function ID():int
        {
            return PacketIDs.IDArcadeMatchJoin;
        }

        public function NetType():int
        {
            return PacketNetType.TCP;
        }

        public function Marshal(w:ByteArray):void
        {
            w.writeByte(this.ArcadeGameType);
            w.writeByte(this.GameMode);
            w.writeInt(this.RoomID);
        }
    }
}