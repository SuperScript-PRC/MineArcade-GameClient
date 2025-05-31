package MineArcade.stage.transition {
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.Scenes;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.utils.LPromise;

    public class CutScene {
        public static function cutScene():LPromise {
            var smc:MovieClip = Scenes.createCutSceneMC()
            smc.x = 0
            smc.y = 0
            smc.setDetectCB(function():Boolean {
                return true
            })
            smc.isTransition = true
            return new LPromise(function(ok:Function):void {
                smc.setOKCB(function():void {
                    ok(null)
                })
                StageMC.root.addChild(smc)
            })
        }

        public static function CutSceneWithWaiter(waiter:LPromise):LPromise {
            var smc:MovieClip = Scenes.createCutSceneMC()
            smc.x = 0
            smc.y = 0
            var _ok:Boolean = false;
            var is_ok:Function = function():Boolean {
                return _ok
            }
            smc.setDetectCB(is_ok)
            smc.isTransition = true
            return new LPromise(function(ok:Function):void {
                smc.setOKCB(ok)
                StageMC.root.addChild(smc)
            })
        }
    }
}
