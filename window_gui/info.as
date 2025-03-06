package window_gui {
    import flash.display.MovieClip;

    public class info {
        private var mc_parent: MovieClip;
        
        public function info(mc){
            mc_parent = MovieClip(mc);
        }

        public function inf(msg: String, x: Number = 0, y: Number = 0, ok_cb: Function = undefined) {
            var windowmc = new InfoWindow()
            mc_parent.addChild(windowmc)
            windowmc.x = x
            windowmc.y = y
            windowmc.setText(msg)
            windowmc.visible = false
            windowmc.ok_cb = ok_cb
        }
    }
}
