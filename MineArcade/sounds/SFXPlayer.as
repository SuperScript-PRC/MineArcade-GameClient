package MineArcade.sounds {
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;

    public class SFXPlayer {
        private var sound:Sound = new Sound();

        public function SFXPlayer(filepath:String) {
            sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:*):void {})
            sound.load(new URLRequest(filepath));
        }

        public function play():void {
            sound.play(0, 1)
        }
    }
}
