package MineArcade.fixer {
    import flash.display.MovieClip;
    import flash.utils.clearInterval;
    import flash.utils.setInterval;

    /**
     * setInterval，在影片剪辑被从场上移除后, 自动调用 clearInterval。
     * 也可以通过 lock_frame=true 使得其不在当前帧后自动调用 clearInterval。
     */
    public class IntervalContext {
        /**
         * 创建一个 IntervalContext。
         * @param mc 所绑定的影片剪辑。
         * @param func 需要 setInterval 的函数。
         * @param delay setInterval 的 delay 参数。
         * @param lock_frame 是否绑定当前帧，不绑定则仅检测影片剪辑是否从场景移除。
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
