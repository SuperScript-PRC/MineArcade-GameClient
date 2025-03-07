package window_gui {
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import window_gui.window_mcs

    public class warning {
        private var mc_parent: MovieClip;
        private const getter: window_mcs = new window_mcs()
        
        public function warning(mc: DisplayObject): void{
            mc_parent = MovieClip(mc);
        }

        public function warn(msg: String, x: Number = 0, y: Number = 0, ok_cb: Function = undefined):void {
            var windowmc: MovieClip = getter.createWarningWindowMC()
            mc_parent.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = ok_cb
        }
    }
}
