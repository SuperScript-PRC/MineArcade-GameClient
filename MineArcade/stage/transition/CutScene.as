package MineArcade.stage.transition
{
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.Scenes;
    import MineArcade.mcs_getter.StageMC;
    public class CutScene {
        public static function cutScene(is_ok:* = undefined, ok_cb:*=undefined):MovieClip{
            var smc: MovieClip = Scenes.createCutSceneMC()
            if(!is_ok){
                is_ok = function():Boolean {
                    return true
                }
            }
            smc.x = 0
            smc.y = 0
            smc.setDetectCB(is_ok)
            smc.setOKCB(ok_cb)
            smc.isTransition = true
            StageMC.root.addChild(smc)
            return smc
        }
    }
}