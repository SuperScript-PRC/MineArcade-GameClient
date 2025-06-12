package MineArcade.arcades.plane_fighter {
    import MineArcade.core.CorArcade;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.utils.Formatter;
    import MineArcade.protocol.packets.arcade.plane_fighter.*;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterAddActor;
    import MineArcade.protocol.ptypes.PlaneFighterActor;
    import MineArcade.protocol.ptypes.PlaneFighterEvent;
    import flash.display.MovieClip;
    import MineArcade.protocol.ptypes.PlaneFighterStageActor;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.ptypes.PlaneFighterScore;
    import MineArcade.user.UserData;
    import MineArcade.protocol.ptypes.PlaneFighterPlayerEntry;
    import flash.utils.getTimer;
    import flash.events.Event;
    import MineArcade.protocol.ptypes.PFPlayerStatus;

    public class PFStage {
        internal var players:Object = {}; // { [RuntimeID]:Player }
        internal var entities:Object = {}; // { [RuntimeID]:Entity }
        internal var core:CorArcade;
        internal var myPlayer:PlaneFighterEntity = null;
        internal var myRuntimeID:int = undefined;
        internal var joystick:JoyStick;
        internal var lastPosSyncTime:int;
        internal var isFiring:Boolean;
        internal var firingTicks:int;

        function PFStage(core:CorArcade) {
            this.core = core
            this.joystick = new JoyStick()
            this.setListeners()
        }

        public function GetPlayer(runtimeId:int):PlaneFighterEntity {
            return this.players[runtimeId]
        }

        public function GetEntity(runtimeId:int):PlaneFighterEntity {
            return this.entities[runtimeId]
        }

        private function setListeners():void {
            const hdl:PacketHandler = this.core.getPacketHander()
            hdl.addPacketListener(PacketIDs.IDPlaneFighterPlayerList, prepare)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterTimer, onTimer)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterAddActor, onAddActor)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterActorEvent, onEvent)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterScores, onScore)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterStage, onStage)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterPlayerStatuses, onStatuses)
            StageMC.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
            StageMC.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp)
            StageMC.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame)
        }

        private function removeListeners():void {
            const hdl:PacketHandler = this.core.getPacketHander()
            hdl.removePacketListener(PacketIDs.IDPlaneFighterPlayerList, prepare)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterTimer, onTimer)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterAddActor, onAddActor)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterActorEvent, onEvent)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterScores, onScore)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterStage, onStage)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterPlayerStatuses, onStatuses)
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp)
            StageMC.stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame)
        }

        public function AddEntity(entity:PlaneFighterEntity):void {
            this.entities[entity.runtimeId] = entity;
            StageMC.root.addChild(entity);
        }

        public function AddPlayer(player:PlaneFighterEntity):void {
            this.players[player.runtimeId] = player;
            player.y = StageMC.stage.height - player.height
            StageMC.root.addChild(player);
        }

        public function RemoveEntity(entity:PlaneFighterEntity):void {
            StageMC.root.removeChild(entity);
            delete this.entities[entity.runtimeId];
        }

        private function prepare(pk:PlaneFighterPlayerList):void {
            var ud:UserData = core.getUserData()
            for each (var entry:PlaneFighterPlayerEntry in pk.Entries) {
                var player:PlaneFighterEntity = Entities.NewPlayerPlane(entry.RuntimeID, StageMC.stage.width / 2, 0);
                this.AddPlayer(player)
                if (entry.UID == ud.uid) {
                    myRuntimeID = entry.RuntimeID
                    myPlayer = player
                }
            }
        }

        private function onStage(pk:PlaneFighterStage):void {
            var getted:PlaneFighterEntity;
            for each (var e:PlaneFighterEntity in this.entities) {
                e.keep = false;
            }
            for each (var player:PlaneFighterStageActor in pk.Players) {
                getted = this.GetPlayer(player.RuntimeID);
                if (getted == null) {
                    trace("Failed to get player:", player.RuntimeID)
                    continue;
                } else {
                    if (getted.runtimeId != this.myPlayer.runtimeId) {
                        getted.UpdatePosition(player.CenterX, player.CenterY)
                    }
                }
            }
            for each (var entity:PlaneFighterStageActor in pk.Entities) {
                getted = this.GetEntity(entity.RuntimeID);
                if (getted == null) {
                    trace("Failed to get entity:", entity.RuntimeID)
                    continue;
                } else {
                    getted.UpdatePosition(entity.CenterX, entity.CenterY)
                    getted.keep = true;
                }
            }
            var removed:Array = [];
            for each (e in this.entities) {
                if (!e.keep) {
                    trace("no keep:", e.runtimeId)
                    removed.push(e)
                }
            }
            for each (e in removed) {
                this.RemoveEntity(e)
            }
        }

        private function onStatuses(pk:PlaneFighterPlayerStatuses):void {
            for each (var s:PFPlayerStatus in pk.Statuses) {
                if (s.RuntimeID == myRuntimeID) {
                    StageMC.root.hp_bar.UpdateProgress(s.HP / 100)
                    StageMC.root.bullet_bar.UpdateProgress(s.Bullets / 200)
                }
            }
        }

        private function onTimer(pk:PlaneFighterTimer):void {
            var minute:int = Math.floor(pk.SecondsLeft / 60)
            var second:int = pk.SecondsLeft % 60
            StageMC.root.timer_text.text = Formatter.zero(minute, 2) + " : " + Formatter.zero(second, 2)
        }

        private function onScore(pk:PlaneFighterScores):void {
            for each (var scoredata:PlaneFighterScore in pk.Scores) {
                if (scoredata.PlayerRuntimeID == myRuntimeID) {
                    StageMC.root.score_text.text = "Score: " + Formatter.zero(scoredata.TotalScore, 8)
                }
            }
        }

        private function onAddActor(pk:PlaneFighterAddActor):void {
            var entity:PlaneFighterEntity;
            for each (var actor:PlaneFighterActor in pk.Actors) {
                switch (actor.ActorType) {
                    case PlaneFighterAddActor.EnemyPlane:
                        entity = Entities.NewEnemyPlane(actor.RuntimeID, actor.X, actor.Y)
                        break
                    case PlaneFighterAddActor.PlayerPlane:
                        entity = Entities.NewPlayerPlane(actor.RuntimeID, actor.X, actor.Y)
                        break
                    case PlaneFighterAddActor.BulletChest:
                        entity = Entities.NewBulletChest(actor.RuntimeID, actor.X, actor.Y)
                        break
                    case PlaneFighterAddActor.FixingPacket:
                        entity = Entities.NewFixingPacket(actor.RuntimeID, actor.X, actor.Y)
                        break
                    default:
                        trace("[Error] Unknown actor type: " + actor.ActorType)
                        return
                }
                this.AddEntity(entity)
            }
        }

        private function onEvent(pk:PlaneFighterActorEvent):void {
            var e:PlaneFighterEntity
            for each (var evt:PlaneFighterEvent in pk.Events) {
                switch (evt.EventID) {
                    case PlaneFighterEvent.EVENT_REMOVE_ENTITY:
                        e = this.entities[evt.EntityRuntimeID]
                        if (!(e is MovieClip)) {
                            trace("[Warning] Remove entity failed:", evt.EntityRuntimeID)
                            return;
                        }
                        this.RemoveEntity(e)
                        break;
                    case PlaneFighterEvent.EVENT_DIED:
                        e = this.entities[evt.EntityRuntimeID]
                        if (!(e is MovieClip)) {
                            trace("[Warning] Create explode failed:", evt.EntityRuntimeID)
                            return;
                        }
                        Effects.CreateExplode(e.x, e.y)
                        this.RemoveEntity(e)
                        break;
                    case PlaneFighterEvent.EVENT_COLORFUL_EXPLODE:
                        e = this.entities[evt.EntityRuntimeID]
                        if (!(e is MovieClip)) {
                            trace("[Warning] Create colorful explode failed:", evt.EntityRuntimeID)
                            return;
                        }
                        Effects.CreateColourfulExplode(e.x, e.y)
                        this.RemoveEntity(e)
                        break;
                    default:
                        trace("[Warning] Unknown event ", evt.EventID, "for entity:", evt.EntityRuntimeID)
                }
            }
        }

        private function onKeyDown(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.SPACE) {
                this.core.getPacketWriter().WritePacket(new PlaneFighterPlayerEvent(PlaneFighterPlayerEvent.StartFire, 0))
                this.isFiring = true;
            }
        }

        private function onKeyUp(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.SPACE) {
                this.core.getPacketWriter().WritePacket(new PlaneFighterPlayerEvent(PlaneFighterPlayerEvent.StopFire, 0))
                this.isFiring = false;
            }
        }

        private function onEnterFrame(event:Event):void {
            const nowTimer:int = getTimer()
            var keyPressed:Boolean = false;
            if (this.myPlayer == null)
                return;
            if (this.joystick.LeftKey) {
                if (this.myPlayer.x > 0) {
                    this.myPlayer.x -= 15
                    keyPressed = true
                }
            } else if (this.joystick.RightKey) {
                if (this.myPlayer.x < StageMC.stage.stageWidth) {
                    this.myPlayer.x += 15
                    keyPressed = true
                }
            }
            if (this.joystick.UpKey) {
                if (this.myPlayer.y > 0) {
                    this.myPlayer.y -= 15
                    keyPressed = true
                }
            } else if (this.joystick.DownKey) {
                if (this.myPlayer.y < StageMC.stage.stageHeight) {
                    this.myPlayer.y += 15
                    keyPressed = true
                }
            }
            if (keyPressed) {
                if (nowTimer - this.lastPosSyncTime >= 100) {
                    this.core.getPacketWriter().WritePacket(new PlaneFighterPlayerMove(this.myPlayer.x, this.myPlayer.y))
                    this.lastPosSyncTime = nowTimer
                }
            }
            if (this.isFiring) {
                firingTicks++;
                if (firingTicks % 10 == 0) {
                    var bullet:MovieClip = Entities.NewBullet(this, this.myPlayer.x - 20, this.myPlayer.y - 50)
                    StageMC.root.addChild(bullet)
                }
            }
        }
    }
}
