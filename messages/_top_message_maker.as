package messages {
    import flash.display.MovieClip;
    import flash.display.Graphics;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.text.TextFormat;
    import mcs_getter.StageMC;

    public class _top_message_maker {
        private var mcs:Array = new Array()
        private static const BORDER_WIDTH:Number = 12
        private static const BORDER_HEIGHT:Number = 8
        private static const STAGE_WIDTH:Number = 1000

        public function _top_message_maker() {
        }

        public function _make_top_message(msg:String):void {
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
            mc.x = STAGE_WIDTH / 2 - mc_width / 2
            mc.y = -mc_height + 5
            var moveTimer:int = 0
            // fps=60
            mc.animateIn_1 = function animateIn_1(_:Event):void {
                if (moveTimer > 0) {
                    moveTimer--
                    mcs.forEach(function(_mc:MovieClip, index:int, array:Array):void {
                        _mc.y += mc_height * 0.05
                    })
                } else {
                    mc.removeEventListener(Event.ENTER_FRAME, mc.animateIn_1)
                    mc.addEventListener(Event.ENTER_FRAME, mc.maintain)
                }
            }
            mc.maintain = function maintain(_:Event):void {
                mc.timer++
                if (mc.timer >= 240) {
                    //trace("x=" + mc.x + ", y=" + mc.y + ", height=" + mc.height + ", width=" + mc.width)
                    mc.removeEventListener(Event.ENTER_FRAME, mc.maintain)
                    mc.addEventListener(Event.ENTER_FRAME, mc.removeOut_1)
                }
            }
            mc.removeOut_1 = function removeOut_1(_:Event):void {
                if (mc.alpha <= 0) {
                    mc.removal()
                } else {
                    mc.alpha -= 0.1
                }
            }
            mc.removal = function removal():void {
                mcs.removeAt(mcs.indexOf(mc))
                mc.removeEventListener(Event.ENTER_FRAME, mc.removeOut_1)
                if (mc.parent != null)
                    mc.parent.removeChild(mc)
            }
            //trace("curr stage: " + stage)
            StageMC.stage.addChild(mc)
            mcs.push(mc)
            moveTimer = 20
            mc.addEventListener(Event.ENTER_FRAME, mc.animateIn_1)
        }
    }
}
