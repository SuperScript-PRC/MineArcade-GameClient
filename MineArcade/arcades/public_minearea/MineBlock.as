package MineArcade.arcades.public_minearea {

    import flash.display.MovieClip;
    import flash.display.Bitmap;

    public class MineBlock extends MovieClip {
        public const id:int = 0;
        public const hard:int = 1;
        public const texture_name:String = "stone";
        public const is_hidden:Boolean = false;
        public var X:Number;
        public var Y:Number;

        public function MineBlock(X:int, Y:int) {
            this.X = X
            this.Y = Y
            this.x = X * 32
            this.y = Y * 32
            if (!is_hidden) {
                var bmp:Bitmap = Textures.GetTexture(texture_name)
                bmp.height = 32
                bmp.width = 32
                this.addChild(bmp)
            }
        }

        public function Digged():void {
            throw new Error("Not implemented")
        }
    }
}
