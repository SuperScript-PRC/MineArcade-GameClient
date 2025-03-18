package MineArcade.arcades.public_minearea {

    import MineArcade.utils.LoadTexture;
    import flash.display.Bitmap;
    import MineArcade.utils.getDictLen;

    public class Textures {
        public static const BlockTextures:Object = { //
                Cobblestone: "cobblestone",
                Stone: "stone",
                CoalOre: "coal_ore",
                IronOre: "iron_ore",
                GoldOre: "gold_ore",
                DiamondOre: "diamond_ore",
                EmeraldOre: "emerald_ore",
                RedstoneOre: "redstone_ore",
                LapisOre: "lapis_ore"}
        public static const ItemTextures:Object = { //
                Coal: "coal",
                Diamond: "diamond",
                Emerald: "emerald",
                RawIron: "raw_iron",
                RawGold: "raw_gold",
                RedstoneDust: "redstone_dust",
                LapisLazuli: "lapis_lazuli"}
        private static var progress:int = 0;
        private static var loaded_textures:Object = {};

        public static function LoadBlockTextures(ok_cb:Function):void {
            var not_loaded_textures_num:int = getDictLen(BlockTextures);
            for (var k:String in BlockTextures) {
                var image_name:* = BlockTextures[k]
                if (image_name == undefined) {
                    throw new Error("Block texture name not found: " + k);
                }
                LoadTexture("resources/images/blocks/" + image_name + ".png", function(name:String, c:Bitmap):void {
                    loaded_textures[name] = c;
                    not_loaded_textures_num--;
                    if (not_loaded_textures_num == 0)
                        ok_cb()
                }, image_name);
            }
        }

        public static function LoadItemTextures(ok_cb:Function):void {
            var not_loaded_textures_num:int = getDictLen(BlockTextures);
            for (var k:String in BlockTextures) {
                var image_name:* = BlockTextures[k]
                if (image_name == undefined) {
                    throw new Error("Block texture name not found: " + k);
                }
                LoadTexture("resources/images/pixel_items/" + image_name + ".png", function(name:String, c:Bitmap):void {
                    loaded_textures[name] = c;
                    not_loaded_textures_num--;
                    if (not_loaded_textures_num == 0)
                        ok_cb()
                }, image_name);
            }
        }

        public static function GetTexture(texture_name:String):Bitmap {
            var t:Bitmap = loaded_textures[texture_name];
            if (t == null) {
                throw new Error("Texture not found: " + texture_name);
            } else {
                return t;
            }
        }
    }
}
