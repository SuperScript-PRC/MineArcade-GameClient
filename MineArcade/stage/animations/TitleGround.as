package MineArcade.stage.animations {

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import MineArcade.define.StageData;
    import MineArcade.fixer.EnterFrameContext;
    import MineArcade.mcs_getter.StageMC;
    import flash.events.IOErrorEvent;

    public class TitleGround {
        private static var diamond_block_png:Bitmap;
        private static var emerald_block_png:Bitmap;
        private static var iron_block_png:Bitmap;
        private static var keep_time:int = 0;
        private static var current_height:int = 1;
        private static var cd:Number = 0;
        private static var load_ok_cb:*;
        private static var load_ok_num:int = 0;

        private static function newPiece(img_path:String, cb:Function):void {
            var ld:Loader = new Loader()
            ld.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                var loader:Loader = Loader(e.target.loader);
                var bitmap:Bitmap = Bitmap(loader.content);
                cb(bitmap)
            })
            var urlreq:URLRequest = new URLRequest(img_path)
            ld.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
                trace("加载方块贴图遇到问题: " + e.text)
            })
            ld.load(urlreq)
        }

        newPiece("resources/images/blocks/diamond_block_gray.png", function(bitmap:Bitmap):void {
            diamond_block_png = bitmap
            load_ok_num++
            if (load_ok_num == 3) {
                if (load_ok_cb != undefined) {
                    load_ok_cb()
                }
            }
        })
        newPiece("resources/images/blocks/emerald_block_gray.png", function(bitmap:Bitmap):void {
            emerald_block_png = bitmap
            load_ok_num++
            if (load_ok_num == 3) {
                if (load_ok_cb != undefined) {
                    load_ok_cb()
                }
            }
        })
        newPiece("resources/images/blocks/iron_block_gray.png", function(bitmap:Bitmap):void {
            iron_block_png = bitmap
            load_ok_num++
            if (load_ok_num == 3) {
                if (load_ok_cb != undefined) {
                    load_ok_cb()
                }
            }
        })

        public static function Start():void {
            if (load_ok_num == 3) {
                _Start()
            } else {
                load_ok_cb = _Start
            }
        }

        private static function _Start():void {
            initBlockColumns()
            EnterFrameContext.Create(StageMC.root, function():void {
                if (cd == 0) {
                    cd = 32;
                    StageMC.root.addChild(createDynamicBlockColumn(-31, StageData.StageHeight - 32, nextStatus()))
                }
                cd--;
            }, true)
        }

        private static function createBlockColumn(x:int, y:int, height:int):MovieClip {
            var m:MovieClip = new MovieClip()
            for (var i:int = 0; i < height; i++) {
                var block_png:Bitmap
                var r:Number = Math.random() * 3
                if (r < 1)
                    block_png = new Bitmap(diamond_block_png.bitmapData)
                else if (r < 2)
                    block_png = new Bitmap(emerald_block_png.bitmapData)
                else
                    block_png = new Bitmap(iron_block_png.bitmapData)
                var colorTransform:ColorTransform = new ColorTransform();
                // colorTransform.redMultiplier = Math.random()
                // colorTransform.greenMultiplier = Math.random()
                // colorTransform.blueMultiplier = Math.random()
                colorTransform.redOffset = -Math.random() * 160
                colorTransform.greenOffset = -Math.random() * 160
                colorTransform.blueOffset = -Math.random() * 255
                r = Math.random() * 3
                if (r < 1)
                    colorTransform.redOffset = Math.random() * 10
                else if (r < 2)
                    colorTransform.greenOffset = Math.random() * 10
                else
                    colorTransform.blueOffset = Math.random() * 10
                block_png.transform.colorTransform = colorTransform
                block_png.width = 32
                block_png.height = 32
                block_png.y = -i * 32
                m.addChild(block_png)
            }
            m.x = x
            m.y = y
            return m
        }

        private static function createDynamicBlockColumn(x:int, y:int, height:int):MovieClip {
            var bc:MovieClip = createBlockColumn(x, y, height)
            EnterFrameContext.Create(bc, function():void {
                bc.x += 1
                // if (bc.x > StageData.StageWidth)
                //     bc.parent.removeChild(bc)
            })
            return bc
        }

        private static function initBlockColumns():void {
            for (var i:int = 0; i <= StageData.StageWidth; i += 32) {
                StageMC.root.addChild(createDynamicBlockColumn(i, StageData.StageHeight - 32, nextStatus()))
            }
        }

        private static function nextStatus():int {
            if (keep_time > 0) {
                keep_time--
            } else {
                var m:Number = Math.random() * 3
                keep_time = int(Math.random() * 5) + 4
                if (m < 1)
                    current_height = Math.max(current_height - 1, 1)
                else if (m > 2)
                    current_height = Math.min(current_height + 1, 5)
            }
            return current_height
        }
    }
}
