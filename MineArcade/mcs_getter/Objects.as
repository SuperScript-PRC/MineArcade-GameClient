package MineArcade.mcs_getter
{
    import flash.display.MovieClip;

    public class Objects{
        public static function createCloud():MovieClip{
            return new Cloud()
        }

        public static function createBullet():MovieClip{
            return new Bullet()
        }
    }
}