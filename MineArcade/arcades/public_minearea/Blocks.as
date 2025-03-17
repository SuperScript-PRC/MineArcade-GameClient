package MineArcade.arcades.public_minearea {

    public class Blocks {
        public static const BlockTable:Object = {0: Air,
                1: Stone,
                2: CoalOre,
                3: IronOre,
                4: GoldOre,
                5: DiamondOre,
                6: EmeraldOre,
                7: RedstoneOre,
                8: LapisOre,
                9: WoodTreasureChest,
                10: IronTreasureChest,
                11: GoldTreasureChest}

        public static function GetBlock(blockID:int):Class {
            return BlockTable[blockID];
        }
    }
}

import MineArcade.arcades.public_minearea.MineBlock;

class Air extends MineBlock {
    static const id:int = 0;
    static const hard:int = 0;

    public function Air(x:int, y:int) {
        super(x, y, "air");
    }

    public override function Digged():void {
        throw new Error("Dig air");
    }
}

class Stone extends MineBlock {
    static const id:int = 1;
    static const hard:int = 4;

    public function Stone(x:int, y:int) {
        super(x, y, "stone");
    }
}

class CoalOre extends MineBlock {
    static const id:int = 2;
    static const hard:int = 8;

    public function CoalOre(x:int, y:int) {
        super(x, y, "coal_ore");
    }
}

class IronOre extends MineBlock {
    static const id:int = 3;
    static const hard:int = 12;

    public function IronOre(x:int, y:int) {
        super(x, y, "iron_ore");
    }
}

class GoldOre extends MineBlock {
    static const id:int = 4;
    static const hard:int = 14;

    public function GoldOre(x:int, y:int) {
        super(x, y, "gold_ore");
    }
}

class DiamondOre extends MineBlock {
    static const id:int = 5;
    static const hard:int = 16;

    public function DiamondOre(x:int, y:int) {
        super(x, y, "diamond_ore");
    }
}

class EmeraldOre extends MineBlock {
    static const id:int = 6;

    public function EmeraldOre(x:int, y:int) {
        super(x, y, "emerald_ore");
    }
}

class RedstoneOre extends MineBlock {
    static const id:int = 7;

    public function RedstoneOre(x:int, y:int) {
        super(x, y, "redstone_ore");
    }
}

class LapisOre extends MineBlock {
    static const id:int = 8;

    public function LapisOre(x:int, y:int) {
        super(x, y, "lapis_ore");
    }
}

class WoodTreasureChest extends MineBlock {
    static const id:int = 9;

    public function WoodTreasureChest(x:int, y:int) {
        super(x, y, "WoodTreasureChest");
    }
}

class IronTreasureChest extends MineBlock {
    static const id:int = 10;

    public function IronTreasureChest(x:int, y:int) {
        super(x, y, "IronTreasureChest");
    }
}

class GoldTreasureChest extends MineBlock {
    static const id:int = 11;

    public function GoldTreasureChest(x:int, y:int) {
        super(x, y, "GoldTreasureChest");
    }
}
