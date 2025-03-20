package MineArcade.arcades.public_minearea {

    public class Blocks {
        public static var BlockTable:*;

        public static function Init():void {
            BlockTable = [ // alright
                Air,
                Stone,
                CoalOre,
                IronOre,
                GoldOre,
                DiamondOre,
                EmeraldOre,
                RedstoneOre,
                LapisOre,
                WoodTreasureChest,
                IronTreasureChest,
                GoldTreasureChest]
        }

        public static function GetBlock(blockID:int):Class {
            var b:* = BlockTable[blockID];
            if (b == null)
                throw new Error("Block not found: " + blockID);
            return b;
        }
    }
}

import MineArcade.arcades.public_minearea.MineBlock;
import MineArcade.arcades.public_minearea.Textures;

class Air extends MineBlock {
    public function Air(x:int, y:int) {
        super(x, y, 0, 0, "air", true);
    }

    public override function Digged():void {
        throw new Error("Dig air");
    }
}

class Stone extends MineBlock {
    public function Stone(x:int, y:int) {
        super(x, y, 1, 4, Textures.BlockTextures.Stone);
    }
}

class CoalOre extends MineBlock {

    public function CoalOre(x:int, y:int) {
        super(x, y, 2, 8, Textures.BlockTextures.CoalOre)
    }
}

class IronOre extends MineBlock {
    public function IronOre(x:int, y:int) {
        super(x, y, 3, 12, Textures.BlockTextures.IronOre);
    }
}

class GoldOre extends MineBlock {
    public function GoldOre(x:int, y:int) {
        super(x, y, 4, 14, Textures.BlockTextures.GoldOre);
    }
}

class DiamondOre extends MineBlock {
    public function DiamondOre(x:int, y:int) {
        super(x, y, 5, 16, Textures.BlockTextures.DiamondOre);
    }
}

class EmeraldOre extends MineBlock {
    public function EmeraldOre(x:int, y:int) {
        super(x, y, 6, 16, Textures.BlockTextures.EmeraldOre);
    }
}

class RedstoneOre extends MineBlock {
    public function RedstoneOre(x:int, y:int) {
        super(x, y, 7, 8, Textures.BlockTextures.RedstoneOre);
    }
}

class LapisOre extends MineBlock {
    public function LapisOre(x:int, y:int) {
        super(x, y, 8, 8, Textures.BlockTextures.LapisOre);
    }
}

class WoodTreasureChest extends MineBlock {
    public function WoodTreasureChest(x:int, y:int) {
        super(x, y, 9, 5, Textures.BlockTextures.WoodTreasureChest, true);
    }
}

class IronTreasureChest extends MineBlock {
    public function IronTreasureChest(x:int, y:int) {
        super(x, y, 10, 10, Textures.BlockTextures.IronTreasureChest, true);
    }
}

class GoldTreasureChest extends MineBlock {
    public function GoldTreasureChest(x:int, y:int) {
        super(x, y, 11, 15, Textures.BlockTextures.GoldTreasureChest, true);
    }
}
