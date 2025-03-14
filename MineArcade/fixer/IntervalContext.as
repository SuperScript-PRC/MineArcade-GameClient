package MineArcade.fixer {
    import flash.display.MovieClip;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;

    public class IntervalContext {
        /*
           在影片剪辑被移除后, 自动调用 clearInterval。
           也可以通过 lock_frame=true 使得其不在当前帧后自动调用 clearInterval。
        */
        public static function Create(mc:MovieClip, func:Function, delay:Number, lock_frame:Boolean = false):void {
            const current_frame:int = mc.currentFrame
            const current_scene:flash.display.Scene = mc.currentScene
            function _interval_ctx():void {
                if (mc.root == null || (lock_frame && (mc.currentFrame != current_frame || mc.currentScene.name != current_scene.name))) {
                    clearInterval(id)
                } else {
                    func()
                }
            }
            var id:uint = setInterval(_interval_ctx, delay)
        }
    }
}
