package MineArcade.utils {

    public class base64 {
        public static function encode(input:String):String {
            var b64Chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var output:String = "";
            var i:Number = 0;
            var byte1:Number, byte2:Number, byte3:Number;
            var enc1:Number, enc2:Number, enc3:Number, enc4:Number;

            while (i < input.length) {
                byte1 = input.charCodeAt(i++) & 0xFF;
                byte2 = i < input.length ? input.charCodeAt(i++) & 0xFF : 0;
                byte3 = i < input.length ? input.charCodeAt(i++) & 0xFF : 0;

                enc1 = byte1 >> 2;
                enc2 = ((byte1 & 0x03) << 4) | (byte2 >> 4);
                enc3 = ((byte2 & 0x0F) << 2) | (byte3 >> 6);
                enc4 = byte3 & 0x3F;

                if (isNaN(byte2)) {
                    enc3 = enc4 = 64;
                } else if (isNaN(byte3)) {
                    enc4 = 64;
                }

                output = output + b64Chars.charAt(enc1) + b64Chars.charAt(enc2) + b64Chars.charAt(enc3) + b64Chars.charAt(enc4);
            }

            return output;
        }
    }
}
