package MineArcade.stage
{
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.StageMC;

    public class MakeTop {
        public static function top(mc:MovieClip):void {
            if (mc.root == null) return
            StageMC.root.removeChild(mc)
            StageMC.root.addChild(mc)
        }
    }
}