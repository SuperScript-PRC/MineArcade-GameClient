

package MineArcade.protocol.packets {

    import MineArcade.utils.Iota;

    public class Pool {
        // General
        private static const iota0:Iota = new Iota();
        private static const iota:Function = iota0.iota;
        public static const IDClientHandshake:int = iota(1);
        public static const IDServerHandshake:int = iota();
        public static const IDUDPConnection:int = iota();
        public static const IDClientLogin:int = iota();
        public static const IDClientLoginResp:int = iota();
        public static const IDKickClient:int = iota();
        public static const IDDialLag:int = iota();
        public static const IDDialLagResp:int = iota();
        public static const IDSimpleEvent:int = iota()
        public static const IDSimpleClientRequest:int = iota();
        // Lobby
        public static const IDPlayerBasics:int = iota();
        public static const IDBackpackResponse:int = iota();
        public static const IDRankRequest:int = iota();
        public static const IDRankResponse:int = iota();
        public static const IDWorldChat:int = iota();
        public static const IDArcadeEntryRequest:int = iota();
        public static const IDArcadeEntryResponse:int = iota();
        public static const IDStartGame:int = iota();
        // Arcade:PublicMineArea
        public static const IDPublicMineAreaChunk:int = iota();
        public static const IDPublicMineareaBlockEvent:int = iota();
        public static const IDPublicMineareaPlayerActorData:int = iota();
        // Max
        public static const MaxPacketID:int = iota();
    }
}