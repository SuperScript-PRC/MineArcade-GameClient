package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.display.Bitmap;

    public class BlockDestroyStage extends MovieClip {
        private var last_status:int = -1;
        private var image:Bitmap;

        public function BlockDestroyStage() {
            super();
            this.visible = false
        }

        public function UpdateStatus(status:int):void {
            if (status >= 10) {
                this.visible = false
                return
            }
            if (!this.visible)
                this.visible = true
            if (status != last_status) {
                last_status = status
                var bmp:Bitmap = Textures.GetDestroyStage(status)
                bmp.height = bmp.width = 32
                if (this.image != null)
                    this.removeChild(this.image)
                this.image = bmp
                this.addChild(bmp)
            }
        }
    }
}
