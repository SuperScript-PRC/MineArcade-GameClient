package MineArcade.arcades.plane_fighter {
    import flash.display.MovieClip;
    import flash.display.Bitmap;

    public class PlaneFighterEntity extends MovieClip {
        public var entity_type:int;
        public var runtimeId:int;

        function PlaneFighterEntity(entity_type:int, x:Number, y:Number, runtimeId:int) {
            this.entity_type = entity_type;
            this.x = x;
            this.y = y;
            this.runtimeId = runtimeId;
        }

        public function PutImage(image:Bitmap):void{
            image.x = -image.width / 2;
            image.y = -image.height / 2;
            this.addChild(image);
        }

        public function UpdatePosition(x:Number, y:Number):void {
            this.x = x;
            this.y = y;
        }
    }
}
