package MineArcade.arcades.public_minearea {

    import flash.display.MovieClip;
    import flash.display.Bitmap;

    public class MineBlock extends MovieClip {
        public const id:int = 0;
        public const hard:int = 1;
        public var X: Number;
        public var Y: Number;

        public function MineBlock(X:int, Y:int, texture_name:String) {
            this.X = x
            this.Y = y
            this.x = X * 32
            this.y = Y * 32
            var bmp:Bitmap = Textures.GetTexture(texture_name)
            bmp.height = 32
            bmp.width = 32
            addChild(bmp)
        }

        public function Digged():void {
            throw new Error("Not implemented")
        }
    }
}
