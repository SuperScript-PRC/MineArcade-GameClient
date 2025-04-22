package MineArcade.arcades.public_minearea {

    import flash.display.MovieClip;
    import flash.display.Bitmap;
    import flash.geom.ColorTransform;

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
        }

        public function Digged():void {
            throw new Error("Not implemented")
        }

        public function ActivateAndUpdate(map:MineAreaMap):void{
            this.Update(map)
            for each (var xy:Array in [[1, 0], [-1, 0], [0, 1], [0, -1]]){
                var b:MineBlock = map.GetBlock(this.X + xy[0], this.Y + xy[1], true)
                if (b != null)
                    b.Update(map)
            }
        }

        public function Update(map:MineAreaMap):void{
            this.updateDark(map)
        }

        public function AirNearby(map:MineAreaMap):int{
            var air_num: int = 0
            for each (var xy:Array in [[1, 0], [-1, 0], [0, 1], [0, -1]]){
                var b:MineBlock = map.GetBlock(this.X + xy[0], this.Y + xy[1], true)
                if (b != null)
                    if (b.id == 0) air_num++
            }
            return air_num
        }

        private function updateDark(map:MineAreaMap):void{
            var solid_blocks_num: int = 0
            for each (var xy:Array in [[1, 0], [-1, 0], [0, 1], [0, -1]]){
                var b:MineBlock = map.GetBlock(this.X + xy[0], this.Y + xy[1], true)
                if (b != null)
                    if (!b.is_hidden) solid_blocks_num++
            }
            var color:ColorTransform = new ColorTransform()
            if (solid_blocks_num == 4) {
                color.redOffset = -255
                color.greenOffset = -255
                color.blueOffset = -255
            } else {
                color.redOffset = 0
                color.greenOffset = 0
                color.blueOffset = 0
            }
            this.transform.colorTransform = color
        }
    }
}

function randColor():int {
    return Math.floor(Math.random() * 0xFFFFFF)
}