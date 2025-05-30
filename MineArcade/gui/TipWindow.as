﻿/**
 * TipWindow
*/
package MineArcade.gui {
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.WindowMC
    import MineArcade.mcs_getter.StageMC

    public class TipWindow {
        public static function info(msg:String, x:Number = 400, y:Number = 200, ok_cb:Function = undefined):void {
            var windowmc:MovieClip = WindowMC.createInfoWindowMC()
            StageMC.stage.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = function():void {
                if(can_resume) resumeRoot()
                ok_cb()
            }
            var can_resume:Boolean = !StageMC.root.isPaused
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
                if(can_resume) resumeRoot()
                ok_cb()
            }
            var can_resume:Boolean = !StageMC.root.isPaused
            pauseRoot()
        }

        public static function error(msg:String, x:Number = 400, y:Number = 200, ok_cb:* = undefined):void {
            var windowmc:MovieClip = WindowMC.createErrorWindowMC()
            StageMC.stage.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = function():void {
                if(can_resume) resumeRoot()
                if(ok_cb != undefined) ok_cb()
            }
            var can_resume:Boolean = !StageMC.root.isPaused
            pauseRoot()
        }

        private static function pauseRoot():void {
            StageMC.root.isPaused = true
        }

        private static function resumeRoot():void {
            StageMC.root.isPaused = false
        }
    }
}
