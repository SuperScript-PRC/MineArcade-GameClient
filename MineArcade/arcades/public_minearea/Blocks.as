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
    static const id:int = 0;
    static const hard:int = 0;
    static const texture_name:String = "air";
    static const is_hidden:Boolean = true;

    public function Air(x:int, y:int) {
        super(x, y);
    }

    public override function Digged():void {
        throw new Error("Dig air");
    }
}

class Stone extends MineBlock {
    static const id:int = 1;
    static const hard:int = 4;
    static const texture_name:String = Textures.BlockTextures.Stone;

    public function Stone(x:int, y:int) {
        super(x, y);
    }
}

class CoalOre extends MineBlock {
    static const id:int = 2;
    static const hard:int = 8;
    static const texture_name:String = Textures.BlockTextures.CoalOre;

    public function CoalOre(x:int, y:int) {
        super(x, y);
    }
}

class IronOre extends MineBlock {
    static const id:int = 3;
    static const hard:int = 12;
    static const texture_name:String = Textures.BlockTextures.IronOre;

    public function IronOre(x:int, y:int) {
        super(x, y);
    }
}

class GoldOre extends MineBlock {
    static const id:int = 4;
    static const hard:int = 14;
    static const texture_name:String = Textures.BlockTextures.GoldOre;

    public function GoldOre(x:int, y:int) {
        super(x, y);
    }
}

class DiamondOre extends MineBlock {
    static const id:int = 5;
    static const hard:int = 16;
    static const texture_name:String = Textures.BlockTextures.DiamondOre;

    public function DiamondOre(x:int, y:int) {
        super(x, y);
    }
}

class EmeraldOre extends MineBlock {
    static const id:int = 6;
    static const hard:int = 16;
    static const texture_name:String = Textures.BlockTextures.EmeraldOre;

    public function EmeraldOre(x:int, y:int) {
        super(x, y);
    }
}

class RedstoneOre extends MineBlock {
    static const id:int = 7;
    static const hard:int = 8;
    static const texture_name:String = Textures.BlockTextures.RedstoneOre;

    public function RedstoneOre(x:int, y:int) {
        super(x, y);
    }
}

class LapisOre extends MineBlock {
    static const id:int = 8;
    static const hard:int = 8;
    static const texture_name:String = Textures.BlockTextures.LapisOre;

    public function LapisOre(x:int, y:int) {
        super(x, y);
    }
}

class WoodTreasureChest extends MineBlock {
    static const id:int = 9;
    static const hard:int = 5;
    static const texture_name:String = Textures.BlockTextures.WoodTreasureChest;

    public function WoodTreasureChest(x:int, y:int) {
        super(x, y);
    }
}

class IronTreasureChest extends MineBlock {
    static const id:int = 10;
    static const hard:int = 10;
    static const texture_name:String = Textures.BlockTextures.IronTreasureChest;

    public function IronTreasureChest(x:int, y:int) {
        super(x, y);
    }
}

class GoldTreasureChest extends MineBlock {
    static const id:int = 11;
    static const hard:int = 15;
    static const texture_name:String = Textures.BlockTextures.GoldTreasureChest;

    public function GoldTreasureChest(x:int, y:int) {
        super(x, y);
    }
}
