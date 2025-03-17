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

        public static function safeGotoAndStop(frame:int, scene:*):void {
            if (scene == undefined)
                scene = root.currentScene.name
            for (var i:int = root.numChildren - 1; i >= 0; i--) {
                var elem:* = StageMC.root.getChildAt(i)
                if (!(elem is MovieClip))
                    continue
                var is_transition:* = elem["isTransition"]
                if (is_transition != undefined && !is_transition) {
                    root.removeChildAt(i)
                }
            }
            root.gotoAndStop(frame, scene)
        }

        public static function safeGotoAndPlay(frame:int, scene:*):void {
            if (scene == undefined)
                scene = root.currentScene.name
            for (var i:int = root.numChildren - 1; i >= 0; i--) {
                var elem:* = StageMC.root.getChildAt(i)
                if (!(elem is MovieClip))
                    continue
                var is_transition:* = elem["isTransition"]
                if (is_transition != undefined && !is_transition) {
                    root.removeChildAt(i)
                }
            }
            root.safeGotoAndPlay(frame, scene)
        }
    }
}
