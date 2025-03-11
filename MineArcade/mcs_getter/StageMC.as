package MineArcade.mcs_getter {
    import flash.display.DisplayObject
    import flash.display.MovieClip;
    import flash.display.Stage;

    public class StageMC {
        public static var stage:Stage;
        public static var root:MovieClip

        public static function initStage(s:Stage):void {
            stage = s
        }

        public static function initRoot(r:DisplayObject):void {
            root = MovieClip(r)
        }

        public static function pauseRoot():void {
            root.isPaused = true
        }

        public static function resumeRoot():void {
            root.isPaused = false
        }

        public static function safeGoto(frame:int, scene:*):void {
            if (scene == undefined)
                scene = root.currentScene.name
            for (var i:int = root.numChildren - 1; i >= 0; i--) {
                if (!root.getChildAt(i)["isTransition"]) {
                    root.removeChildAt(i)
                }
            }
            root.gotoAndStop(frame, scene)
        }
    }
}
