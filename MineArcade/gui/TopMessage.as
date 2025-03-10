package MineArcade.gui {

    import flash.display.MovieClip;
    import flash.display.Graphics;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.text.TextFormat;
    import MineArcade.define.StageData
    import MineArcade.mcs_getter.StageMC;

    public class TopMessage {
        private static var scrolly:Number = 0;
        private static var mcs:Vector.<MovieClip> = new Vector.<MovieClip>()
        private static const BORDER_WIDTH:Number = 12
        private static const BORDER_HEIGHT:Number = 8

        public static function show(msg:String):void {
            _make_top_message(msg)
        }

        private static function _make_top_message(msg:String):void {
            var mc:MovieClip = new MovieClip();
            var tf:TextField = new TextField();
            var g:Graphics = mc.graphics;
            var tfmt:TextFormat = new TextFormat();
            tfmt.font = "Unifont"
            tfmt.color = 0xFFFFFF
            tfmt.size = 20
            tf.width = 400
            tf.text = msg
            tf.setTextFormat(tfmt)

            var mc_width:Number = tf.textWidth + BORDER_WIDTH * 2
            var mc_height:Number = tf.textHeight + BORDER_HEIGHT * 2

            g.beginFill(0x000000, 0.4);
            g.drawRoundRect(0, 0, mc_width, mc_height, 8, 8);
            g.endFill()

            tf.x = BORDER_WIDTH
            tf.y = BORDER_HEIGHT

            mc.addChild(tf)
            mc.timer = 0
            mc.x = StageData.StageWidth / 2 - mc_width / 2
            var moveTimer:int = 0
            // fps=60
            mc.maintain = function maintain(_:Event):void {
                mc.timer++
                if (mc.timer >= 240) {
                    mc.removeEventListener(Event.ENTER_FRAME, mc.maintain)
                    mc.addEventListener(Event.ENTER_FRAME, mc.removeOut_1)
                }
            }
            mc.removeOut_1 = function removeOut_1(_:Event):void {
                if (mc.alpha <= 0) {
                    mc.removal()
                } else {
                    mc.alpha -= 0.04
                }
            }
            mc.removal = function removal():void {
                mcs.removeAt(mcs.indexOf(mc))
                mc.removeEventListener(Event.ENTER_FRAME, mc.removeOut_1)
                if (mc.parent != null)
                    mc.parent.removeChild(mc)
            }
            StageMC.stage.addChild(mc)
            mcs.push(mc)
            mc.y = -activate_scroll(mc_height + 5) + 5
            mc.addEventListener(Event.ENTER_FRAME, mc.maintain)
        }

        private static function scroll(_:Event):void {
            if (scrolly <= 0) {
                StageMC.stage.removeEventListener(Event.ENTER_FRAME, scroll)
                return
            }
            var max_sub_value:Number = Math.min(scrolly, 5)
            scrolly -= max_sub_value
            mcs.forEach(function(_mc:MovieClip, index:int, vec:Vector.<MovieClip>):void {
                _mc.y += max_sub_value
            })
        }

        private static function activate_scroll(mv:Number):Number {
            if (scrolly == 0)
                StageMC.stage.addEventListener(Event.ENTER_FRAME, scroll)
            scrolly += mv
            return scrolly
        }
    }
}
