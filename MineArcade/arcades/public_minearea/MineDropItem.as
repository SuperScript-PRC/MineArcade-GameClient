package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class MineDropItem extends MovieClip {
        public function MineDropItem(x:int, y:int):void {
            super();
            this.x = x + define.BLOCK_SIZE / 2
            this.y = y + define.BLOCK_SIZE / 2
        }

        protected function loadTexture(name:String):void {
            var bmp:Bitmap = Textures.GetTexture(name)
            bmp.height = 25
            bmp.width = 25
            bmp.x = -10
            bmp.y = -10
            this.addChild(bmp)
            this.Fade(1290, -100)
        }

        private function Fade(fx:int, fy:int):void {
            const self:* = this
            const enter_frame:Function = function(_:*):void {
                if (root == null) {
                    removeEventListener(Event.ENTER_FRAME, enter_frame)
                    if (parent != null) parent.removeChild(self)
                } else {
                    var fly_speed_x:Number = (fx - x) / 40
                    var fly_speed_y:Number = (fy - y) / 40
                    x += fly_speed_x
                    y += fly_speed_y
                    if (Math.abs(fx - x) < 20 && Math.abs(fy - y) < 20) {
                        removeEventListener(Event.ENTER_FRAME, enter_frame)
                        parent.removeChild(self)
                    }
                }
            }
            addEventListener(Event.ENTER_FRAME, enter_frame)
        }
    }
}



