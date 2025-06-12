package MineArcade.arcades.plane_fighter {
    import MineArcade.utils.TextureStorage;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.arcade.StartGame;
    import MineArcade.utils.LPromise;
    import flash.display.Bitmap;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterAddActor;
    import MineArcade.mcs_getter.Objects;
    import flash.display.MovieClip;
    import MineArcade.define.GameType;
    import flash.events.Event;

    public class Entities {

        public static var textures:TextureStorage;

        /**
         * @param textures Object<texture_name, url>
         */
        public static function InitAndLoadTextures(core:CorArcade):LPromise {
            textures = new TextureStorage();
            return textures.LoadTextures({ //
                    "PlayerPlane": "resources/images/plane_fighter/player_plane.png", //
                    "EnemyPlane": "resources/images/plane_fighter/enemy_plane.png", //
                    "BulletChest": "resources/images/plane_fighter/bullet_chest.png", //
                    "FixingPacket": "resources/images/plane_fighter/fixing_packet.png" //
                }).then(function(ok:Function):void {
                    core.getPacketWriter().WritePacket(new StartGame(GameType.PLANE_FIGHTER, ""))
                    ok()
                })
        }

        public static function NewPlayerPlane(runtimeId:int, x:Number, y:Number):PlaneFighterEntity {
            var entity:PlaneFighterEntity = new PlaneFighterEntity(PlaneFighterAddActor.PlayerPlane, x, y, runtimeId)
            const t:Bitmap = textures.GetTexture("PlayerPlane")
            t.height = PLAYER_HEIGHT
            t.width = PLAYER_WIDTH
            t.x = -t.height / 2
            entity.addChild(t);
            return entity
        }

        public static function NewEnemyPlane(runtimeId:int, x:Number, y:Number):PlaneFighterEntity {
            var entity:PlaneFighterEntity = new PlaneFighterEntity(PlaneFighterAddActor.EnemyPlane, x, y, runtimeId)
            const t:Bitmap = textures.GetTexture("EnemyPlane")
            t.height = ENEMY_PLANE_HEIGHT
            t.width = ENEMY_PLANE_WIDTH
            t.x = -t.height / 2
            t.y = -t.width / 2
            entity.addChild(t);
            return entity
        }

        public static function NewBullet(stage:PFStage, x:Number, y:Number):MovieClip {
            var entity:MovieClip = Objects.createBullet()
            entity.x = x
            entity.y = y
            function destroy():void {
                entity.removeEventListener(Event.ENTER_FRAME, onEnterFrame)
                entity.parent.removeChild(entity)
            }
            function onEnterFrame(event:Event):void {
                if (entity.parent == null) {
                    return
                }
                if (entity.y < 0) {
                    destroy()
                    return
                }
                entity.y -= 12
                for each (var e:MovieClip in stage.entities) {
                    if (e is PlaneFighterEntity && entity.hitTestObject(e)) {
                        var entity2:PlaneFighterEntity = e as PlaneFighterEntity
                        if (entity2.entity_type != PlaneFighterAddActor.PlayerPlane) {
                            destroy()
                            return
                        }
                    }
                }
            }
            entity.addEventListener(Event.ENTER_FRAME, onEnterFrame)
            return entity
        }

        public static function NewBulletChest(runtimeId:int, x:Number, y:Number):PlaneFighterEntity {
            var entity:PlaneFighterEntity = new PlaneFighterEntity(PlaneFighterAddActor.BulletChest, x, y, runtimeId)
            const t:Bitmap = textures.GetTexture("BulletChest")
            t.height = BULLET_CHEST_HEIGHT
            t.width = BULLET_CHEST_WIDTH
            t.x = -t.height / 2
            t.y = -t.width / 2
            entity.addChild(t);
            return entity
        }

        public static function NewFixingPacket(runtimeId:int, x:Number, y:Number):PlaneFighterEntity {
            var entity:PlaneFighterEntity = new PlaneFighterEntity(PlaneFighterAddActor.FixingPacket, x, y, runtimeId)
            const t:Bitmap = textures.GetTexture("FixingPacket")
            t.height = FIXING_PACKET_HEIGHT
            t.width = FIXING_PACKET_WIDTH
            t.x = -t.height / 2
            t.y = -t.width / 2
            entity.addChild(t);
            return entity
        }
    }

}

const PLAYER_WIDTH:int = 80
const PLAYER_HEIGHT:int = 100

const ENEMY_PLANE_WIDTH:int = 90
const ENEMY_PLANE_HEIGHT:int = 90

const PLAYER_BULLET_WIDTH:int = 15
const ENEMY_BULLET_WIDTH:int = 15

const PLAYER_BULLET_HEIGHT:int = 15
const ENEMY_BULLET_HEIGHT:int = 15

const PLAYER_LASER_WIDTH:int = 5
const ENEMY_LASER_WIDTH:int = 5

const PLAYER_LASER_HEIGHT:int = 180
const ENEMY_LASER_HEIGHT:int = 180

const BULLET_CHEST_WIDTH:int = 60
const BULLET_CHEST_HEIGHT:int = 60

const FIXING_PACKET_WIDTH:int = 60
const FIXING_PACKET_HEIGHT:int = 60

const TNT_WIDTH:int = 32
const TNT_HEIGHT:int = 32
