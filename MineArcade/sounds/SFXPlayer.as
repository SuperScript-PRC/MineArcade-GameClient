package MineArcade.sounds {
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import MineArcade.utils.LPromise;

    public class SFXPlayer {
        private var filepath:String;
        private var sound:Sound = new Sound();
        private var _promise:LPromise;

        public function SFXPlayer(filepath:String, needPromise:Boolean = false) {
            this.filepath = filepath;
            const self:SFXPlayer = this;
            if (needPromise)
                this._promise = new LPromise(function(ok:Function):void {
                    sound.addEventListener(Event.COMPLETE, function(_:Event):void {
                        ok(self)
                    })
                });
            sound.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
                trace(e.text)
            })
            sound.load(new URLRequest(filepath));
        }

        public static function LoadSFX(filepath:String):LPromise {
            const sfx:SFXPlayer = new SFXPlayer(filepath, true);
            return sfx._promise;
        }

        public function play():void {
            sound.play(0, 1)
        }
    }
}
