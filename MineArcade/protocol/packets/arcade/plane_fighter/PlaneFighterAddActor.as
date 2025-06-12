package MineArcade.protocol.packets.arcade.plane_fighter {
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.ptypes.PlaneFighterActor;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.PacketNetType;
    import flash.utils.ByteArray;
    import MineArcade.protocol.PacketReader;
    import MineArcade.utils.Iota;

    public class PlaneFighterAddActor implements ServerPacket {
        private static var iota:Function = new Iota().iota;
        public static var PlayerPlane:int = iota(0); // 玩家
        public static var EnemyPlane:int = iota(); // 小型敌机
        public static var PlayerBullet:int = iota(); // 玩家子弹
        public static var PlayerLaser:int = iota(); // 玩家镭射
        public static var PlayerMissile:int = iota(); // 玩家导弹
        public static var TNT:int = iota(); // TNT
        public static var EnemyBullet:int = iota(); // 敌方子弹
        public static var EnemyLaser:int = iota(); // 敌方镭射
        public static var BulletChest:int = iota(); // 弹匣箱
        public static var FixingPacket:int = iota(); // 修补包
        public static var BossPlane:int = iota();

        public var Actors:Array;

        function PlaneFighterAddActor(Actor:Array = undefined) {
            this.Actors = Actors;
        }

        public function ID():int {
            return PacketIDs.IDPlaneFighterAddActor;
        }

        public function NetType():int {
            return PacketNetType.UDP;
        }

        public function Unmarshal(r:ByteArray):void {
            this.Actors = PacketReader.readArray(r, PlaneFighterActor)
        }
    }
}
