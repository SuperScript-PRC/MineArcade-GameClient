package MineArcade.utils
{
    public class Formatter {
        public static function zero(num:int, length:int):String {
            var string:String = num.toString()
            while (string.length < length) {
                string = "0" + string
            }
            return string
        }
    }
}