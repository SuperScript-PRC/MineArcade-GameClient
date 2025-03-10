package MineArcade.mcs_getter
{
    import flash.display.MovieClip;

    // InfoWindow, WarningWindow, ErrorWindow 在 main.fla 中被定义

    public class WindowMC
    {
        public static function createInfoWindowMC(): MovieClip{
            return new InfoWindow()
        }
        public static function createWarningWindowMC(): MovieClip{
            return new WarningWindow()
        }
        public static function createErrorWindowMC(): MovieClip{
            return new ErrorWindow()
        }
    }
}