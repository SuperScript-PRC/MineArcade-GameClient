package core
{
    import flash.display.DisplayObject;
    import mcs_getter.StageMC;
    import flash.display.Stage;

    public class Main {
        public static var GCore:CorArcade;

        public static function Init(stage:Stage, root:DisplayObject):void {
            GCore = new CorArcade();
            StageMC.initStage(stage)
            StageMC.initRoot(root)
        }
    }
}