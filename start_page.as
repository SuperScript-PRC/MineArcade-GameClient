package {
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;

    public class start_page {

        public function makeCloud(mc):void {
            var cloud_mc:Cloud = new Cloud();
            mc.addChild(cloud_mc);
            cloud_mc.y = Math.round(Math.random() * 200 + 100);
            cloud_mc.x = 1200;
            const cloud_gray:Number = Math.random() * 0.8 + 0.2;
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.redMultiplier = cloud_gray;
            colorTransform.greenMultiplier = cloud_gray;
            colorTransform.blueMultiplier = cloud_gray;
            cloud_mc.transform.colorTransform = colorTransform;
        }
    }
}
