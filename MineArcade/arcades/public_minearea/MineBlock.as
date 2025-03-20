package MineArcade.arcades.public_minearea {

    import flash.display.MovieClip;
    import flash.display.Bitmap;

    public class MineBlock extends MovieClip {
        public var id:int = undefined;
        public var hard:int = undefined;
        public var texture_name:String = null;
        public var is_hidden:Boolean = undefined;
        public var X:Number;
        public var Y:Number;

        public function MineBlock(X:int, Y:int, id:int = undefined, hard:int = undefined, _texture_name:String = null, is_hidden:Boolean = false) {
            this.X = X
            this.Y = Y
            this.x = X * 32
            this.y = Y * 32
            this.id = id
            this.hard = hard
            this.texture_name = _texture_name
            this.is_hidden = is_hidden
            if (!this.is_hidden) {
                if (texture_name == null)
                    throw new Error("Texture can't be null")
                var bmp:Bitmap = Textures.GetTexture(texture_name)
                bmp.height = 32
                bmp.width = 32
                this.addChild(bmp)
            }
            else {
                // this.graphics.beginFill(randColor())
                // this.graphics.drawRect(0, 0, 32, 32)
                // this.graphics.endFill()
            }
        }

        public function Digged():void {
            throw new Error("Not implemented")
        }
    }
}

function randColor():int {
    return Math.floor(Math.random() * 0xFFFFFF)
}