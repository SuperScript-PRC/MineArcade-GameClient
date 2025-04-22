package MineArcade.arcades.public_minearea
{
    public class Utils {
        public static function getBlocksInLine(x1: int, y1: int, x2: int, y2: int):Vector.<MineBlock>{
            var _x1:Number = x1, _y1:Number = y1, _x2:Number = x2, _y2:Number = y2
            if (_x1 > _x2) {
                x1 = _x2
                x2 = _x1
                y1 = _y2
                y2 = _y1
            }
            var blocks:Vector.<MineBlock> = new Vector.<MineBlock>()
            const k:Number = (y2 - y1) / (x2 - x1)
            const b:Number = y1 - k * x1
            for (var i:Number = x1; i < x2; )
            return ...
        }
    }
}