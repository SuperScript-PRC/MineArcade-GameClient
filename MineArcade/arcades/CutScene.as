package MineArcade.arcades
{
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.Scenes;
    import MineArcade.mcs_getter.StageMC;
    public class CutScene {
        public static function cutScene(cut_ok_cb:Function):void{
            var smc: MovieClip = Scenes.createCutSceneMC()
            smc.x = 0
            smc.y = 0
            smc.setDetectCB(cut_ok_cb)
            StageMC.root.addChild(smc)
        }
    }
}