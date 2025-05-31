package MineArcade.fixer {
    import flash.display.MovieClip;
    import flash.events.Event;

    /**
     * 指定当离开当前帧时执行的回调。
     */
    public class FrameContext {
        /**
         * 创建一个 FrameContext。
         * @param mc 所绑定的影片剪辑。
         * @param leaveFrame 当离开当前帧时执行的回调。
         */
        public static function Create(mc:MovieClip, leaveFrame:Function):void {
            const current_frame:int = mc.currentFrame
            const current_scene:flash.display.Scene = mc.currentScene
            function _frame_ctx(_:Event):void {
                if (mc.root == null || mc.currentFrame != current_frame || mc.currentScene.name != current_scene.name) {
                    mc.removeEventListener(Event.ENTER_FRAME, _frame_ctx)
                    leaveFrame()
                }
            }
            mc.addEventListener(Event.ENTER_FRAME, _frame_ctx)
        }
    }
}
