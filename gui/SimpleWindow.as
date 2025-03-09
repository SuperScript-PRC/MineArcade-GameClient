package gui {
    import flash.display.MovieClip;
    import mcs_getter.WindowMC
    import mcs_getter.StageMC

    public class SimpleWindow {
        public static function info(msg:String, x:Number = 400, y:Number = 200, ok_cb:Function = undefined):void {
            var windowmc:MovieClip = WindowMC.createInfoWindowMC()
            StageMC.stage.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = function():void {
                resumeRoot()
                ok_cb()
            }
            pauseRoot()
        }

        public static function warning(msg:String, x:Number = 400, y:Number = 200, ok_cb:Function = undefined):void {
            var windowmc:MovieClip = WindowMC.createWarningWindowMC()
            StageMC.stage.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = function():void {
                resumeRoot()
                ok_cb()
            }
            pauseRoot()
        }

        public static function error(msg:String, x:Number = 400, y:Number = 200, ok_cb:Function = undefined):void {
            var windowmc:MovieClip = WindowMC.createErrorWindowMC()
            StageMC.stage.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = function():void {
                resumeRoot()
                ok_cb()
            }
            pauseRoot()
        }

        private static function pauseRoot():void {
            StageMC.stage.isPaused = true
        }

        private static function resumeRoot():void {
            StageMC.stage.isPaused = false
        }
    }
}
