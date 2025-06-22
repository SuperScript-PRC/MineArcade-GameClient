package MineArcade.mcs_getter {
    import flash.display.DisplayObject
    import flash.display.MovieClip;
    import flash.display.Stage;
    import MineArcade.stage.transition.CutScene;
    import MineArcade.utils.LPromise;
    import MineArcade.stage.transition.ClearStage;

    public class StageMC {
        public static var stage:Stage;
        public static var root:MovieClip;
        public static var exit_cbs:Array = new Array();

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

        public static function safeGotoAndStop(frame:int, scene:String=""):void {
            execute_exit_cbs()
            if (scene == "")
                scene = root.currentScene.name
            ClearStage()
            root.gotoAndStop(frame, scene)
        }

        public static function safeGotoAndPlay(frame:int, scene:String=""):void {
            execute_exit_cbs()
            if (scene == "")
                scene = root.currentScene.name
            ClearStage()
            root.gotoAndPlay(frame, scene)
        }

        public static function Restart():void{
            execute_exit_cbs()
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

        public static function GoArcade(arcadeSceneName:String, frame:int=1):LPromise{
            return CutScene.cutScene().then(function(ok:Function):void{
                safeGotoAndStop(frame, arcadeSceneName)
                ok()
            })
        }

        public static function GoArcade2(arcadeSceneName:String, frame:int=1):LPromise{
            return CutScene.cutScene2().then(function(ok:Function):void{
                safeGotoAndStop(frame, arcadeSceneName)
                ok()
            })
        }

        public static function ClearListeners():void {
            for (var prop:String in root) {
                if (root.hasOwnProperty(prop) && prop.indexOf("on") == 0) {
                    delete root[prop];
                }
            }
        }

        public static function RegistExit(cb:Function):void{
            exit_cbs.push(cb);
        }

        private static function execute_exit_cbs():void{
            for each (var cb:Function in exit_cbs) {
                cb();
            }
            exit_cbs = [];
        }
    }
}
