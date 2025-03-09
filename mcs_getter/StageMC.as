package mcs_getter {
    import flash.display.DisplayObject
    import flash.display.MovieClip;
    import flash.display.Stage;

    public class StageMC {
        public static var stage:Stage;
        public static var root:MovieClip

        public static function initStage(s:Stage):void {
            stage = s
        }
        public static function initRoot(r:DisplayObject):void {
            root = MovieClip(r)
        }
    }
}
