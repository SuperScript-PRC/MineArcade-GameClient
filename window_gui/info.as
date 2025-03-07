package window_gui {
    import flash.display.MovieClip;
        import flash.display.DisplayObject;
    import window_gui.window_mcs

    public class info {
        private var mc_parent: MovieClip;
        private const getter: window_mcs = new window_mcs()
        
        public function info(mc: DisplayObject){
            mc_parent = MovieClip(mc);
        }

        public function inf(msg: String, x: Number = 0, y: Number = 0, ok_cb: Function = undefined):void {
            var windowmc: MovieClip = getter.createInfoWindowMC()
            mc_parent.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = ok_cb
        }
    }
}
