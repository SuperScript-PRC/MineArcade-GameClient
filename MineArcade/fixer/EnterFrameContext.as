package MineArcade.fixer {

    import flash.display.MovieClip;
    import flash.events.Event;

    public class EnterFrameContext {
        /*
        创建一个 onEnterFrame 事件监听器上下文。
        我们知道, 在 Flash 中, 在一个影片剪辑中使用了类似 onEnterFrame 这样的事件时,
        当元件被从舞台移除, onEnterFrame 并不会立即被移除, 这时候它的执行逻辑就会出现一些问题,
        例如, 元件的 `root` 或者 `parent` 属性会被立即丢失, 导致在访问其的时候发生报错.
        使用了这个上下文管理器, 就可以在当影片剪辑被移除时立刻停止监听 onEnterFrame 事件.
        另外, 考虑到有的时候 onEnterFrame 可能只需要在某一帧生效, 跳转到其他帧的时候立即移除,
        你也可以使用 lock_frame 参数来设定 onEnterFrame 事件是否仅锁定在本帧生效.
        */
        public static function Create(mc:MovieClip, onEnterFrame:Function, lock_frame:Boolean = false):void {
            const current_frame:int = mc.currentFrame
            const current_scene:flash.display.Scene = mc.currentScene
            function _enterframe_ctx(_:Event):void {
                if (mc.root == null || (lock_frame && (mc.currentFrame != current_frame || mc.currentScene.name != current_scene.name))) {
                    // trace("Removed:"+mc)
                    // trace("root==null: " + (mc.root == null))
                    // trace("current_frame: " + (mc.currentFrame != current_frame))
                    // trace("current_scene: " + (mc.currentScene.name != current_scene.name))
                    mc.removeEventListener(Event.ENTER_FRAME, _enterframe_ctx)
                } else {
                    onEnterFrame()
                }
            }
            mc.addEventListener(Event.ENTER_FRAME, _enterframe_ctx)
        }
    }
}
