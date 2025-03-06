package window_gui {
    import flash.display.MovieClip;

    public class warning {
        private var mc_parent: MovieClip;
        
        public function warning(mc){
            mc_parent = MovieClip(mc);
        }

        public function warn(msg: String, x: Number = 0, y: Number = 0, ok_cb: Function = undefined) {
            var windowmc = new WarningWindow()
            mc_parent.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = ok_cb
        }
    }
}
