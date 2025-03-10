package MineArcade.sounds {
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import MineArcade.messages.top_message;

    public class SFXPlayer {
        private var sound:Sound = new Sound();

        public function SFXPlayer(filepath:String) {
            sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
                top_message.show("无法播放音乐, 资源丢失")
            })
            sound.load(new URLRequest(filepath));
        }

        public function play():void {
            sound.play(0, 1)
        }
    }
}
