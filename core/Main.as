package core
{
    import flash.display.DisplayObject;
    import mcs_getter.StageMC;

    public class Main {
        public static var GCore:CorArcade;

        public static function Init(stage:DisplayObject):void {
            GCore = new CorArcade();
            StageMC.initStage(stage)
        }
    }
}