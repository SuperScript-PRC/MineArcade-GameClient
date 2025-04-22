package MineArcade.arcades.public_minearea {

    public class MineDropItems {
        public static function GetBlockDropItem(block_id:int):Class {
            switch (block_id) {
                case MineBlocks.IDAir:
                    throw new Error("Air can't drop items")
                case MineBlocks.IDStone:
                    return Cobblestone
                case MineBlocks.IDCobblestone:
                    return Cobblestone
                case MineBlocks.IDCoalOre:
                    return Coal
                case MineBlocks.IDIronOre:
                    return RawIron
                case MineBlocks.IDGoldOre:
                    return RawGold
                case MineBlocks.IDDiamondOre:
                    return Diamond
                case MineBlocks.IDEmeraldOre:
                    return Emerald
                case MineBlocks.IDRedstoneOre:
                    return RedstoneDust
                case MineBlocks.IDLapisOre:
                    return LapisLazuli
                default:
                    throw new Error("Block not found: " + block_id)
            }
            
        }
    }
}

import MineArcade.arcades.public_minearea.MineDropItem;

class Cobblestone extends MineDropItem {
    public function Cobblestone(x:int, y:int) {
        super(x, y);
        this.loadTexture("cobblestone");
    }
}

class Coal extends MineDropItem {
    public function Coal(x:int, y:int) {
        super(x, y);
        this.loadTexture("coal");
    }
}

class RawIron extends MineDropItem {
    public function RawIron(x:int, y:int) {
        super(x, y);
        this.loadTexture("raw_iron");
    }
}

class RawGold extends MineDropItem {
    public function RawGold(x:int, y:int) {
        super(x, y);
        this.loadTexture("raw_gold");
    }
}

class Diamond extends MineDropItem {
    public function Diamond(x:int, y:int) {
        super(x, y);
        this.loadTexture("diamond");
    }
}

class Emerald extends MineDropItem {
    public function Emerald(x:int, y:int) {
        super(x, y);
        this.loadTexture("emerald");
    }
}

class RedstoneDust extends MineDropItem {
    public function RedstoneDust(x:int, y:int) {
        super(x, y);
        this.loadTexture("redstone_dust");
    }
}

class LapisLazuli extends MineDropItem {
    public function LapisLazuli(x:int, y:int) {
        super(x, y);
        this.loadTexture("lapis_lazuli");
    }
}
