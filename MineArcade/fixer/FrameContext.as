package MineArcade.fixer {
    import flash.display.MovieClip;
    import flash.events.Event;

    public class FrameContext {
        /*
           EnterFrameContext, 但是强制绑定当前帧。
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
