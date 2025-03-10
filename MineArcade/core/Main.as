package MineArcade.core {
    import flash.display.DisplayObject;
    import flash.display.Stage;
    import MineArcade.mcs_getter.StageMC;
    import flash.utils.setInterval;
    import flash.utils.clearInterval;
    import MineArcade.protecter.FlashPlayerProtecter;

    public class Main {
        public static var GCore:CorArcade;
        public static var intervalIDs:Vector.<uint> = new Vector.<uint>()

        public static function Init(stage:Stage, root:DisplayObject):void {
            GCore = new CorArcade();
            StageMC.initStage(stage)
            StageMC.initRoot(root)
            FlashPlayerProtecter.Protect()
        }

        public static function Exit():void {
            StageMC.root.removeChildren()
            StageMC.root.gotoAndPlay(1)
            intervalIDs.forEach(function(id:uint, index:int, vec:Vector):void {
                clearInterval(id)
            })
            for (var i:int = 0; i < intervalIDs.length; i++) intervalIDs.removeAt(0)
        }

        public static function setInterval(func:Function, time:int):uint {
            var id:uint = flash.utils.setInterval(func, time)
            intervalIDs.push(id)
            return id
        }
    }
}
