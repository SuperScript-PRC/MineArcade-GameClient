package MineArcade.fixer {

    import flash.display.MovieClip;
    import flash.events.Event;

    public class EventContext {
        /*
           EnterFrameContext 的泛用版.
           可以针对任意事件类型使用.
         */
        public static function Create(mc:MovieClip, listenRoot:*, evtType:String, onEvent:Function, lock_frame:Boolean = false):void {
            const current_frame:int = mc.currentFrame
            function _enterframe_detect(evt:Event):void {
                if (mc.root == null || (lock_frame && mc.currentFrame != current_frame)) {
                    listenRoot.removeEventListener(Event.ENTER_FRAME, _enterframe_detect)
                    listenRoot.removeEventListener(evtType, onEvent)
                }
            }
            listenRoot.addEventListener(Event.ENTER_FRAME, _enterframe_detect)
            listenRoot.addEventListener(evtType, onEvent)
        }
    }
}
