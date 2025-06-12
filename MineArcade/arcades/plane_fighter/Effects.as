package MineArcade.arcades.plane_fighter {

    import flash.display.MovieClip;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.Event;

    public class Effects {
        public static function CreateExplode(x:Number, y:Number, radius:Number = 30, delay_ticks:Number = 120):void {
            var mc:MovieClip = new Explode(x, y, radius, delay_ticks);
            StageMC.stage.addChild(mc);
        }

        public static function CreateColourfulExplode(x:Number, y:Number, radius:Number = 30, delay_ticks:Number = 120):void {
            var mc:MovieClip = new ColourfulExplode(x, y, radius, delay_ticks);
            StageMC.stage.addChild(mc);
        }
    }
}

import flash.display.MovieClip;
import flash.events.Event;

class Explode extends MovieClip {
    private var ticks:int;
    private var radius:Number;
    private var delay_ticks:Number;

    function Explode(x:Number, y:Number, radius:Number = 10, delay_ticks:Number = 120) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.delay_ticks = delay_ticks;
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    function onEnterFrame(event:Event):void {
        this.ticks++;
        if (this.ticks % 2 == 0) {
            const color_depth:int = int(Math.random() * 0xFF)
            const color:int = color_depth << 16 | color_depth << 8 | color_depth
            parent.addChild(new ExplodeBall(x + this.radius * (Math.random() * 2 - 1), y + this.radius * (Math.random() * 2 - 1), color))
        }
        if (this.ticks > this.delay_ticks) {
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            parent.removeChild(this);
        }
    }
}

class ColourfulExplode extends MovieClip {
    private var ticks:int;
    private var radius:Number;
    private var delay_ticks:Number;

    function ColourfulExplode(x:Number, y:Number, radius:Number = 10, delay_ticks:Number = 120) {
        this.x = x;
        this.y = y;
        this.radius = radius;
        this.delay_ticks = delay_ticks;
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    function onEnterFrame(event:Event):void {
        this.ticks++;
        if (this.ticks % 2 == 0) {
            var r:uint = int(Math.random() * 255);
            var g:uint = int(Math.random() * 255);
            var b:uint = int(Math.random() * 255);
            switch (int(Math.random() * 3)) {
                case 0:
                    r = 128 + int(Math.random() * 128);
                    break;
                case 1:
                    g = 128 + int(Math.random() * 128);
                    break;
                case 2:
                    b = 128 + int(Math.random() * 128);
                    break;
            }
            const color:int = r << 16 | g << 8 | b
            parent.addChild(new ExplodeBall(x + this.radius * (Math.random() * 2 - 1), y + this.radius * (Math.random() * 2 - 1), color, 1))
        }
        if (this.ticks > this.delay_ticks) {
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            parent.removeChild(this);
        }
    }
}

class ExplodeBall extends MovieClip {
    function ExplodeBall(x:Number, y:Number, color:uint, alpha:Number=0.6) {
        var self:ExplodeBall = this;
        this.x = x;
        this.y = y;
        this.alpha = alpha;
        const maxBig:Number = Math.random() * 40 + 20;
        var a:Number = 8;
        graphics.beginFill(color)
        graphics.drawCircle(0, 0, maxBig / 3)
        graphics.endFill()
        function onEnterFrame(_:*):void {
            a -= 3;
            if (height + a <= 0) {
                removeEventListener(Event.ENTER_FRAME, onEnterFrame)
                parent.removeChild(self)
                return
            }
            height += a;
            width += a;
        }
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame)
    }
}
