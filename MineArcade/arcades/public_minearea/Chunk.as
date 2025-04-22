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
            this.x = chunkX * define.CHUNK_BORDER_SIZE
            this.y = (31 - chunkY) * define.CHUNK_BORDER_SIZE
            var i_x:int, i_y:int;
            for (i_y = 0; i_y < define.CHUNK_SIZE; i_y++) {
                for (i_x = 0; i_x < define.CHUNK_SIZE; i_x++) {
                    var b:MineBlock = MineBlocks.NewBlock(chunkX * define.CHUNK_SIZE + i_x, chunkY * define.CHUNK_SIZE + i_y, bdata.readByte())
                    b.x = i_x * define.BLOCK_SIZE
                    b.y = (define.CHUNK_SIZE - 1 - i_y) * define.BLOCK_SIZE
                    blocks[GetBlockIndexByBlockXY(i_x, i_y)] = b
                    this.addChild(b)
                }
            }
        }

        public function ActivateAndUpdate(map:MineAreaMap):void{
            this.Update(map)
            for each (var xy:Array in [[1, 0], [-1, 0], [0, 1], [0, -1]]){
                var c:Chunk = map.GetChunk(this.chunkX + xy[0], this.chunkY + xy[1], true)
                if (c != null)
                    c.Update(map)
            }
        }

        public function Update(map:MineAreaMap):void{
            for each (var b:MineBlock in blocks) {
                b.Update(map)
            }
        }

        public function GetToPlayerDistance(player:WorldPlayer):Number {
            return Math.sqrt(Math.pow((this.center_x - player.x), 2) + Math.pow((this.center_y - player.y), 2))
        }

        public function ModifyBlock(map: MineAreaMap, blockX:int, blockY:int, newBlockID:int):void {
            var index:int = GetBlockIndexByBlockXY(blockX % define.CHUNK_SIZE, blockY % define.CHUNK_SIZE)
            this.removeChild(blocks[index])
            var newBlock:MineBlock = MineBlocks.NewBlock(blockX, blockY, newBlockID)
            newBlock.x = (blockX % define.CHUNK_SIZE) * define.BLOCK_SIZE
            newBlock.y = (define.CHUNK_SIZE - 1 - blockY % define.CHUNK_SIZE) * define.BLOCK_SIZE
            blocks[index] = newBlock
            this.addChild(newBlock)
            newBlock.ActivateAndUpdate(map)
        }

        public function GetBlock(blockX:int, blockY:int):MineBlock {
            return blocks[GetBlockIndexByBlockXY(blockX, blockY)]
        }

        public function get center_x():Number {
            return this.x + define.CHUNK_BORDER_SIZE / 2
        }

        public function get center_y():Number {
            return this.y + define.CHUNK_BORDER_SIZE / 2
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
            return x + y * define.MAP_BORDER_CHUNK_X
        }

        public static function GetBlockIndexByBlockXY(x:int, y:int):int {
            return x + y * define.CHUNK_SIZE
        }
    }
}

