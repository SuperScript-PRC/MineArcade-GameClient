package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;

    public class Chunk extends MovieClip {
        public var chunkX:int;
        public var chunkY:int;
        public var blocks:Vector.<MineBlock> = new Vector.<MineBlock>(256)
        private var inited:Boolean = false

        // 16x16
        public function Chunk(chunkX:int, chunkY:int, bdata:ByteArray):void {
            super()
            this.chunkX = chunkX
            this.chunkY = chunkY
            this.x = chunkX * 512
            this.y = (31 - chunkY) * 512
            var i_x:int, i_y:int;
            for (i_y = 0; i_y < define.CHUNK_SIZE; i_y++) {
                for (i_x = 0; i_x < define.CHUNK_SIZE; i_x++) {
                    var b:MineBlock = Blocks.NewBlock(chunkX * define.CHUNK_SIZE + i_x, chunkY * define.CHUNK_SIZE + i_y, bdata.readByte())
                    b.x = i_x * define.CHUNK_SIZE
                    b.y = (15 - i_y) * 32
                    blocks[GetBlockIndexByBlockXY(i_x, i_y)] = b
                    this.addChild(b)
                }
            }
        }

        public function GetToPlayerDistance(player:WorldPlayer):Number {
            return Math.sqrt(Math.pow((this.center_x - player.x), 2) + Math.pow((this.center_y - player.y), 2))
        }

        public function ModifyBlock(blockX:int, blockY:int, newBlockID:int):void {
            var index:int = GetBlockIndexByBlockXY(blockX % 16, blockY % 16)
            this.removeChild(blocks[index])
            var newBlock:MineBlock = Blocks.NewBlock(blockX, blockY, newBlockID)
            newBlock.x = (blockX % 16) * 32
            newBlock.y = (15 - blockY % 16) * 32
            blocks[index] = newBlock
            this.addChild(newBlock)
        }

        public function GetBlock(blockX:int, blockY:int):MineBlock {
            return blocks[GetBlockIndexByBlockXY(blockX, blockY)]
        }

        public function get center_x():Number {
            return this.x + 256
        }

        public function get center_y():Number {
            return this.y + 256
        }

        // public function CanBeRemoved(player:WorldPlayer):Boolean {
        //     // 当区块离开舞台的时候卸载
        //     var c:Boolean = Math.abs(this.center_x - player.x) < PLAYER_SIGHT && Math.abs(this.center_y - player.y) < PLAYER_SIGHT
        //     if (!this.inited && c)
        //         this.inited = true;
        //     if (this.inited)
        //         return !c
        //     else
        //         return false
        // }
        public static function GetMapIndexByChunkXY(x:int, y:int):int {
            return x + y * 32
        }

        public static function GetBlockIndexByBlockXY(x:int, y:int):int {
            return x + y * 16
        }
    }
}

const BLOCK_SIZE:int = 16
const PLAYER_SIGHT:int = 48 * BLOCK_SIZE
