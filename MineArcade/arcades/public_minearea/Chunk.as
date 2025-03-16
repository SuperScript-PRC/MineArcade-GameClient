package MineArcade.arcades.public_minearea {
    import flash.display.MovieClip;
    import flash.utils.ByteArray;
    import MineArcade.define.StageData;

    public class Chunk extends MovieClip {
        public var chunkX:int;
        public var chunkY:int;
        public var blocks:Vector.<MineBlock> = new Vector.<MineBlock>()

        // 16x16
        public function Chunk(chunkX:int, chunkY:int, bdata:ByteArray):void {
            super()
            this.chunkX = chunkX
            this.chunkY = chunkY
            this.x = chunkX * 512
            this.y = chunkY * 512
            var i_x:int, i_y:int;
            for (i_x = 0; i_x < 16; i_x++) {
                for (i_y = 0; i_y < 16; i_y++) {
                    var b:MineBlock = Blocks.GetBlock(bdata.readByte())(i_x * 32, i_y * 32)
                    this.addChild(b)
                    blocks.push(b)
                }
            }
        }

        public function GetToPlayerDistance(player:WorldPlayer):Number {
            var center_x:Number = this.x + 256
            var center_y:Number = this.y + 256
            return Math.sqrt(Math.pow((center_x - player.x), 2) + Math.pow((center_y - player.y), 2))
        }

        public function get center_x():Number {
            return this.x + 256
        }

        public function get center_y():Number {
            return this.y + 256
        }

        public function CanBeRemoved(player:WorldPlayer):Boolean {
            // 当区块离开舞台的时候卸载
            return Math.abs(this.center_x - player.x) > StageData.StageWidth / 2 + 256 || Math.abs(this.center_y - player.y) > StageData.StageHeight / 2 + 256
        }
    }
}
