package MineArcade.protocol.packets.general
{
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.ptypes.RankData;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;

    public class RankResponse implements ServerPacket {
        public var Ranks:Array;
        public var PlayerRank:RankData;

        public function ID():int{
            return PacketIDs.IDRankResponse;
        }

        public function NetType():int{
            return PacketNetType.TCP;
        }

        public function Unmarshal(r:ByteArray):void{
            var count:int = r.readByte();
            this.Ranks = PacketReader.readArray(r, RankData)
            const pr:RankData = new RankData();
            pr.Unmarshal(r);
            this.PlayerRank = pr;
        }
    }
}