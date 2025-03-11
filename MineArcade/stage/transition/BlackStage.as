package MineArcade.stage.transition {

    import flash.display.MovieClip;
    import flash.display.Graphics;
    import MineArcade.define.StageData;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.Event;
    import MineArcade.stage.MakeTop;

    public class BlackStage {
        public static function Create(is_ok:Function, cb:Function):void {
            function transitionIn(_:Event):void {
                bmc.alpha += 0.05
                if (bmc.alpha >= 1) {
                    bmc.removeEventListener(Event.ENTER_FRAME, transitionIn)
                    bmc.addEventListener(Event.ENTER_FRAME, transitionMaintain)
                    ClearStage()
                }
            }
            function transitionMaintain(_:Event):void {
                if (is_ok()) {
                    bmc.removeEventListener(Event.ENTER_FRAME, transitionMaintain)
                    bmc.addEventListener(Event.ENTER_FRAME, transitionOut)
                    MakeTop.top(bmc)
                }
            }
            function transitionOut(_:Event):void {
                bmc.alpha -= 0.05
                if (bmc.alpha <= 0) {
                    bmc.removeEventListener(Event.ENTER_FRAME, transitionOut)
                    StageMC.root.removeChild(bmc)
                    cb()
                }
            }
            var bmc:MovieClip = new MovieClip();
            var gph:Graphics = bmc.graphics;
            gph.beginFill(0x000000);
            gph.drawRect(0, 0, StageData.StageWidth, StageData.StageHeight)
            gph.endFill()
            bmc.alpha = 0
            bmc.addEventListener(Event.ENTER_FRAME, transitionIn)
            bmc.isTransition = true
            StageMC.root.addChild(bmc)
            StageMC.pauseRoot()
        }
    }
}
