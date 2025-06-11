package MineArcade.define
{
    import MineArcade.utils.Iota;

    public class GameType
    {   
        private static const iota0:Iota = new Iota();
        private var iota:Function = iota0.iota;
        public static const LOBBY:int = 0;
        public static const PUBLIC_MINEAREA:int = 1;
        public static const PLANE_FIGHTER:int = 2;
    }
}