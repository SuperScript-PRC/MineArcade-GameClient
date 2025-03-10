package MineArcade.stage.transition
{
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.Scenes;
    import MineArcade.mcs_getter.StageMC;
    public class CutScene {
        public static function cutScene(is_ok:Function):void{
            var smc: MovieClip = Scenes.createCutSceneMC()
            smc.x = 0
            smc.y = 0
            smc.setDetectCB(is_ok)
            StageMC.root.addChild(smc)
        }
    }
}