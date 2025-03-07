package window_gui
{
    import flash.display.MovieClip;

    public class window_mcs
    {
        public function createInfoWindowMC(): MovieClip{
            return new InfoWindow()
        }
        public function createWarningWindowMC(): MovieClip{
            return new WarningWindow()
        }
        public function createErrorWindowMC(): MovieClip{
            return new ErrorWindow()
        }
    }
}