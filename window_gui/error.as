package window_gui {
    import flash.display.MovieClip;
    import window_gui.window_mcs
    import flash.display.DisplayObject

    public class error {
        private var mc_parent: MovieClip;
        private const getter: window_mcs = new window_mcs()
        
        public function error(mc: DisplayObject){
            mc_parent = MovieClip(mc);
        }

        public function err(msg: String, x: Number = 0, y: Number = 0, ok_cb: Function = undefined):void {
            var windowmc: MovieClip = getter.createErrorWindowMC()
            mc_parent.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = ok_cb
        }
    }
}
