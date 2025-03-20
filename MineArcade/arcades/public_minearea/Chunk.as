package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;

    public class Chunk extends MovieClip {
        public var chunkX:int;
        public var chunkY:int;
        public var blocks:Vector.<MineBlock> = new Vector.<MineBlock>()
        private var inited:Boolean = false

        // 16x16
        public function Chunk(chunkX:int, chunkY:int, bdata:ByteArray):void {
            super()
            this.chunkX = chunkX
            this.chunkY = chunkY
            this.x = chunkX * 512
            this.y = (32 - chunkY) * 512
            var i_x:int, i_y:int;
            for (i_x = 0; i_x < 16; i_x++) {
                for (i_y = 0; i_y < 16; i_y++) {
                    var bt_type:int = bdata.readByte()
                    var bt:Class = Blocks.GetBlock(bt_type)
                    var b:MineBlock = new bt(i_x, i_y)
                    this.addChild(b)
                    blocks.push(b)
                }
            }
        }

        public function GetToPlayerDistance(player:WorldPlayer):Number {
            return Math.sqrt(Math.pow((this.center_x - player.x), 2) + Math.pow((this.center_y - player.y), 2))
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
        public static function GetMapIndexByChunkXY(x: int, y: int):int{
            return x + y * 32
        }
    }
}

const BLOCK_SIZE:int = 16
const PLAYER_SIGHT:int = 48 * BLOCK_SIZE
