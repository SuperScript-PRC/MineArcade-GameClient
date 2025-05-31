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
            var root_mcs: Array = [];
            for (var i:int = root.numChildren - 1; i >= 0; i--) {
                var elem:* = StageMC.root.getChildAt(i)
                if (!(elem is MovieClip) || elem["isTransition"] != undefined || !elem["isTransition"])
                    continue
                root_mcs.push(elem)
            }
            for each (var mc:MovieClip in root_mcs) {
                root.removeChild(mc)
            }
            root.gotoAndPlay(frame, scene)
        }

        public static function Restart():void{
            clearStage()
            safeGotoAndPlay(1, "Preload")
        }

        public static function clearStage():void {
            var mcs: Array = [];
            for (var i:int = 0; i < root.numChildren; i++) {
                var elem:* = root.getChildAt(i);
                //if (elem is MovieClip)
                mcs.push(elem)
            }
            for each (var mc:* in mcs) {
                root.removeChild(mc)
            }
        }
    }
}
