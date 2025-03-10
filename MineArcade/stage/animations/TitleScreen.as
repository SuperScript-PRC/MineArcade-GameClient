package MineArcade.stage.animations {
    import MineArcade.mcs_getter.Objects;
    import flash.display.MovieClip;
    import MineArcade.mcs_getter.StageMC;
    import flash.geom.ColorTransform;

    public class TitleScreen {
        public static function makeCloud():void {
            var cloud_mc:MovieClip = Objects.createCloud();
            cloud_mc.y = Math.round(Math.random() * 200 + 200);
            cloud_mc.x = 1480;
            const cloud_gray:Number = Math.random() * 0.8 + 0.2;
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.redMultiplier = cloud_gray;
            colorTransform.greenMultiplier = cloud_gray;
            colorTransform.blueMultiplier = cloud_gray;
            cloud_mc.transform.colorTransform = colorTransform;
            StageMC.stage.addChild(cloud_mc);

        }
    }
}
