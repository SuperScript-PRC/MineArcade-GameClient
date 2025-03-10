package MineArcade.sounds {
    import flash.media.SoundChannel;
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import MineArcade.messages.top_message;

    public class BGMPlayer {
        private var sound:Sound = new Sound();
        private var channel:SoundChannel;

        public function BGMPlayer(filepath:String) {
            sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
                top_message.show("无法播放音乐, 资源丢失")
            })
            sound.load(new URLRequest(filepath));
        }

        public function play(loops:int=2147483647):void {
            channel = sound.play(0, loops)
        }

        public function stop():void {
            channel.stop()
        }
    }
}
