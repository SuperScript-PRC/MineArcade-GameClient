package MineArcade.fixer {

    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * EnterFrameContext 的泛用版.
     * 可以针对任意事件类型使用.
     */
    public class EventContext {
        /**
         * 创建一个 EnterFrameContext。
         * @param mc 所绑定的影片剪辑。
         * @param listenRoot 任意的 root 层对象。
         * @param evtType 事件类型。
         * @param onEvent 事件回调。
         * @param lock_frame 是否绑定当前帧。如果不绑定当前帧，则检测 mc.root 是否为 null。
         */
        public static function Create(mc:MovieClip, listenRoot:*, evtType:String, onEvent:Function, lock_frame:Boolean = false):void {
            const current_scene:String = mc.currentScene.name
            const current_frame:int = mc.currentFrame
            function _enterframe_detect(evt:Event):void {
                if (mc.root == null || (lock_frame && (mc.currentFrame != current_frame || mc.currentScene.name != current_scene))) {
                    listenRoot.removeEventListener(Event.ENTER_FRAME, _enterframe_detect)
                    listenRoot.removeEventListener(evtType, onEvent)
                }
            }
            listenRoot.addEventListener(Event.ENTER_FRAME, _enterframe_detect)
            listenRoot.addEventListener(evtType, onEvent)
        }
    }
}
