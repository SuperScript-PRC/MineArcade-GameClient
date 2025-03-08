package mcs_getter {
    import flash.display.DisplayObject
    import flash.display.MovieClip;

    public class StageMC {
        public static var stage:MovieClip;

        public static function initStage(mc:DisplayObject):void {
            stage = MovieClip(mc);
        }
    }
}
