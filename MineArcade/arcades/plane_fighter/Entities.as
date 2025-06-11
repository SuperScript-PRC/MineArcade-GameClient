package MineArcade.arcades.plane_fighter {
    import MineArcade.utils.TextureStorage;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.arcade.StartGame;
    import MineArcade.utils.LPromise;

    public class Entities {

        public static const texture_name:Array = ["PlayerPlane",
            "EnemyPlane", "Bullet", "Missile", "Laser"]

        public static var textures:TextureStorage;

        public static function Init(core:CorArcade):LPromise {
            textures = new TextureStorage();
            return textures.LoadTextures({ //
                    "PlayerPlane": "resources/images/plane_fighter/player_plane.png"}) //
                .then(function():void {
                    core.getPacketWriter().WritePacket(new StartGame())
                })
        }
    }

}
