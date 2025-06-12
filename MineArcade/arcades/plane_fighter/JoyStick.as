package MineArcade.arcades.plane_fighter {
    import flash.ui.Keyboard;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.Event;
    import flash.events.KeyboardEvent;

    public class JoyStick {
        public var LeftKey:Boolean;
        public var RightKey:Boolean;
        public var UpKey:Boolean;
        public var DownKey:Boolean;
        private var keyDownCounter:int;

        function JoyStick():void {
            this.LeftKey = false;
            this.RightKey = false;
            this.UpKey = false;
            this.DownKey = false;
            this.keyDownCounter = 0;
            StageMC.stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
            StageMC.stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
        }

        public function Unload():void {
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
        }

        public function KeyDown(event:KeyboardEvent):void {
            switch (event.keyCode) {
                case Keyboard.LEFT:
                    this.LeftKey = true;
                    break;
                case Keyboard.RIGHT:
                    this.RightKey = true;
                    break;
                case Keyboard.UP:
                    this.UpKey = true;
                    break;
                case Keyboard.DOWN:
                    this.DownKey = true;
                    break;
            }
        }

        public function KeyUp(event:KeyboardEvent):void {
            switch (event.keyCode) {
                case Keyboard.LEFT:
                    this.LeftKey = false;
                    break;
                case Keyboard.RIGHT:
                    this.RightKey = false;
                    break;
                case Keyboard.UP:
                    this.UpKey = false;
                    break;
                case Keyboard.DOWN:
                    this.DownKey = false;
                    break;
            }

        }
    }
}
