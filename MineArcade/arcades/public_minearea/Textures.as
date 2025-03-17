package MineArcade.arcades.public_minearea {

    import MineArcade.utils.TextureLoader;
    import flash.display.Bitmap;

    public class Textures {
        private static var progress:int = 0;
        private static var textures:Object = {};

        private static function getNeedLoadTextures():Object {
            return {
                Air: "air",
                Cobblestone: "cobblestone",
                Stone: "stone",
                CoalOre: "coal_ore",
                IronOre: "iron_ore",
                GoldOre: "gold_ore",
                DiamondOre: "diamond_ore",
                EmeraldOre: "emerald_ore",
                RedstoneOre: "redstone_ore",
                LapisOre: "lapis_ore",

                Coal: "coal",
                Diamond: "diamond",
                Emerald: "emerald",
                RawIron: "raw_iron",
                RawGold: "raw_gold",
                RedstoneDust: "redstone_dust",
                LapisLazuli: "lapis_lazuli"
            }
        }

        public static function loadTextures():void {
            var need_load_textures:Object = getNeedLoadTextures();
            var all_textures_num:int = need_load_textures.length;
            for each (var k:String in textures) {
                TextureLoader.loadTexture("resources/images/blocks/" + need_load_textures[k] + ".png", function(c:Bitmap):void {
                    textures[k] = c;
                });
            }
        }

        public static function GetTexture(texture_name: String):Bitmap {
            return textures[texture_name];
        }
    }
}
