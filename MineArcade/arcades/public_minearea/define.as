package MineArcade.arcades.public_minearea
{
    public class define {
        public static const BLOCK_SIZE:int = 32
        public static const CHUNK_SIZE:int = 16
        public static const MAP_BORDER_CHUNK_X: int = 32
        public static const MAP_BORDER_CHUNK_Y: int = 32
        public static const MAP_BORDER_X: int = MAP_BORDER_CHUNK_X * CHUNK_SIZE
        public static const MAP_BORDER_Y: int = MAP_BORDER_CHUNK_Y * CHUNK_SIZE
        public static const CHUNK_BORDER_SIZE: int = CHUNK_SIZE * BLOCK_SIZE
        public static const PLAYER_MINE_DISTANCE: int = 5
        public static const PLAYER_BUILD_DISTANCE: int = 5
    }
}