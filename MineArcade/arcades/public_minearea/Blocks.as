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

        public static function NewBlock(X: int, Y: int, blockID:int):MineBlock {
            var block_type:Class = Blocks.GetBlock(blockID)
            return new block_type(X, Y)
        }
    }
}

import MineArcade.arcades.public_minearea.MineBlock;
import MineArcade.arcades.public_minearea.Textures;

class Air extends MineBlock {
    public function Air(X: int, Y: int) {
        super(X, Y, 0, 0, "air", true);
    }

    public override function Digged():void {
        throw new Error("Dig air");
    }
}

class Stone extends MineBlock {
    public function Stone(X: int, Y: int) {
        super(X, Y, 1, 4, Textures.BlockTextures.Stone);
    }
}

class CoalOre extends MineBlock {

    public function CoalOre(X: int, Y: int) {
        super(X, Y, 2, 8, Textures.BlockTextures.CoalOre)
    }
}

class IronOre extends MineBlock {
    public function IronOre(X: int, Y: int) {
        super(X, Y, 3, 12, Textures.BlockTextures.IronOre);
    }
}

class GoldOre extends MineBlock {
    public function GoldOre(X: int, Y: int) {
        super(X, Y, 4, 14, Textures.BlockTextures.GoldOre);
    }
}

class DiamondOre extends MineBlock {
    public function DiamondOre(X: int, Y: int) {
        super(X, Y, 5, 16, Textures.BlockTextures.DiamondOre);
    }
}

class EmeraldOre extends MineBlock {
    public function EmeraldOre(X: int, Y: int) {
        super(X, Y, 6, 16, Textures.BlockTextures.EmeraldOre);
    }
}

class RedstoneOre extends MineBlock {
    public function RedstoneOre(X: int, Y: int) {
        super(X, Y, 7, 8, Textures.BlockTextures.RedstoneOre);
    }
}

class LapisOre extends MineBlock {
    public function LapisOre(X: int, Y: int) {
        super(X, Y, 8, 8, Textures.BlockTextures.LapisOre);
    }
}

class WoodTreasureChest extends MineBlock {
    public function WoodTreasureChest(X: int, Y: int) {
        super(X, Y, 9, 5, Textures.BlockTextures.WoodTreasureChest, true);
    }
}

class IronTreasureChest extends MineBlock {
    public function IronTreasureChest(X: int, Y: int) {
        super(X, Y, 10, 10, Textures.BlockTextures.IronTreasureChest, true);
    }
}

class GoldTreasureChest extends MineBlock {
    public function GoldTreasureChest(X: int, Y: int) {
        super(X, Y, 11, 15, Textures.BlockTextures.GoldTreasureChest, true);
    }
}
