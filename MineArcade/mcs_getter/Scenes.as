package MineArcade.mcs_getter
{
    import flash.display.MovieClip;

    // InfoWindow, WarningWindow, ErrorWindow 在 main.fla 中被定义

    public class Scenes
    {
        public static function createCutSceneMC(): MovieClip{
            return new CutSceneMC()
        }
    }
}