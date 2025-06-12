package MineArcade.utils {

    import flash.display.Bitmap;

    public class TextureStorage {
        internal var textures:Object;

        function TextureStorage() {
            this.textures = new Object();
        }

        /**
         * 加载材质
         * @param textures Object<texture_name, url>
         * @return LPromise<void>
         */
        public function LoadTextures(texture_mapping:Object):LPromise {
            var tasks:Array = [];
            for (var texture_name:String in texture_mapping) {
                tasks.push(LoadTexture(texture_mapping[texture_name], texture_name).then(function(ok:Function, as_name:String, bmp:Bitmap):void {
                    textures[as_name] = bmp;
                    ok()
                }));
            }
            return AsyncGather(tasks)
        }

        public function GetTexture(texture_name:String):Bitmap {
            var texture:Bitmap = this.textures[texture_name];
            if (texture == null) {
                trace("[Error] GetTexture: " + texture_name + " not found")
                return new Bitmap();
            } else {
                return new Bitmap(texture.bitmapData);
            }
        }
    }
}
