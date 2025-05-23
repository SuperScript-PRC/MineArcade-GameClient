package MineArcade.protocol.packets {

    public class Pool {
        public static const IDClientHandshake:int = 1
        public static const IDServerHandshake:int = 2
        public static const IDClientLogin:int = 3
        public static const IDClientLoginResp:int = 4
        public static const IDKickClient:int = 5
        public static const IDDialLag:int = 6
        public static const IDDialLagResp:int = 7
        public static const IDPlayerBasics:int = 8
        public static const IDBackpackResponse:int = 9
        public static const IDSimpleEvent:int = 10
        public static const IDPublicMineAreaChunk:int = 11
        public static const IDPublicMineareaBlockEvent:int = 12
        public static const IDPublicMineareaPlayerActorData:int = 13
        public static const IDArcadeEntryRequest:int = 14
        public static const IDArcadeEntryResponse:int = 15
        public static const IDStartGame:int = 16
    }
}


