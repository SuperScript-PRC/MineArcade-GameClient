package MineArcade.arcades.plane_fighter {
    import MineArcade.utils.LPromise;
    import MineArcade.sounds.SFXPlayer;
    import MineArcade.utils.AsyncGather;

    public class SFX {
        public static var sfxs:Object;
        public static var bonus_1:SFXPlayer;
        public static var bonus_2:SFXPlayer;
        public static var explode:SFXPlayer;

        public static function LoadSFX():LPromise {
            var bonus_1_p:LPromise = SFXPlayer.LoadSFX("resources/sounds/sfx/bonus.mp3");
            var bonus_2_p:LPromise = SFXPlayer.LoadSFX("resources/sounds/sfx/bonus2.mp3");
            var explode_p:LPromise = SFXPlayer.LoadSFX("resources/sounds/sfx/explode.mp3");
            return AsyncGather([bonus_1_p.then(function(ok:Function, s:SFXPlayer):void {
                bonus_1 = s;
                ok()
            }), bonus_2_p.then(function(ok:Function, s:SFXPlayer):void {
                bonus_2 = s;
                ok()
            }), explode_p.then(function(ok:Function, s:SFXPlayer):void {
                explode = s;
                ok()
            })])
        }
    }
}
