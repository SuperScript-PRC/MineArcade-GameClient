package MineArcade.arcades.plane_fighter {
    import MineArcade.core.CorArcade;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.utils.Formatter;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterTimer;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterAddActor;
    import MineArcade.protocol.ptypes.PlaneFighterActor;
    import MineArcade.protocol.ptypes.PlaneFighterEvent;
    import flash.display.MovieClip;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterActorEvent;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterStage;
    import MineArcade.protocol.ptypes.PlaneFighterStageActor;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterPlayerEvent;
    import MineArcade.protocol.PacketHandler;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterScores;
    import MineArcade.protocol.ptypes.PlaneFighterScore;
    import MineArcade.protocol.packets.arcade.plane_fighter.PlaneFighterPlayerList;
    import MineArcade.user.UserData;
    import MineArcade.protocol.ptypes.PlaneFighterPlayerEntry;

    public class PFStage {
        internal var entities:Object = {}; // { [RuntimeID]:Entity }
        internal var core:CorArcade;
        internal var myRuntimeID:int = undefined;

        function PFStage(core:CorArcade) {
            this.core = core
            this.setListeners()
        }

        public function GetEntity(runtimeId:int):PlaneFighterEntity {
            for each (var entity:PlaneFighterEntity in this.entities) {
                if (entity.runtimeId == runtimeId) {
                    return entity
                }
            }
            return null
        }

        private function setListeners():void {
            trace("LS SetListeners")
            const hdl:PacketHandler = this.core.getPacketHander()
            hdl.addPacketListener(PacketIDs.IDPlaneFighterTimer, onTimer)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterAddActor, onAddActor)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterActorEvent, onEvent)
            hdl.addPacketListener(PacketIDs.IDPlaneFighterScores, onScore)
            StageMC.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
            StageMC.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp)
        }

        private function removeListeners():void {
            const hdl:PacketHandler = this.core.getPacketHander()
            hdl.removePacketListener(PacketIDs.IDPlaneFighterTimer, onTimer)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterAddActor, onAddActor)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterActorEvent, onEvent)
            hdl.removePacketListener(PacketIDs.IDPlaneFighterScores, onScore)
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
            StageMC.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp)
        }

        private function prepare(pk:PlaneFighterPlayerList):void{
            var ud:UserData = core.getUserData()
            for each (var entry:PlaneFighterPlayerEntry in pk.Entries) {
                if (entry.UID == ud.uid) {
                    myRuntimeID = entry.RuntimeID
                }
            }
        }

        private function onTimer(pk:PlaneFighterTimer):void {
            var minute:int = Math.floor(pk.SecondsLeft / 60)
            var second:int = pk.SecondsLeft % 60
            trace("Time Left: " + minute + ":" + second)
            StageMC.root.timer_text.text = Formatter.zero(minute, 2) + " : " + Formatter.zero(second, 2)
        }

        private function onScore(pk:PlaneFighterScores):void{
            for each (var scoredata:PlaneFighterScore in pk.Scores) {
                if (scoredata.PlayerRuntimeID == myRuntimeID) {
                    StageMC.root.score_text.text = "Score: " + Formatter.zero(scoredata.TotalScore, 8)
                }
            }
        }

        private function onAddActor(pk:PlaneFighterAddActor):void {
            for each (var actor:PlaneFighterActor in pk.Actors) {
                var entity:PlaneFighterEntity = new PlaneFighterEntity(actor.ActorType, actor.X, actor.Y, actor.RuntimeID)
                this.entities[actor.RuntimeID] = entity
                StageMC.root.addChild(entity)
            }
        }

        private function onEvent(pk:PlaneFighterActorEvent):void {
            for each (var evt:PlaneFighterEvent in pk.Events) {
                switch (evt.EventID) {
                    case PlaneFighterEvent.EVENT_REMOVE_ENTITY:
                        var e:PlaneFighterEntity = this.entities[evt.EntityRuntimeID]
                        if (!(e is MovieClip))
                            return;
                        StageMC.root.removeChild(e);
                        delete this.entities[evt.EntityRuntimeID];
                }
            }
        }

        private function on_stage_sync(pk:PlaneFighterStage):void {
            var e:PlaneFighterStageActor;
            var entity:PlaneFighterEntity;
            for each (e in pk.Entities) {
                entity = this.GetEntity(e.RuntimeID)
                if (entity != null) {
                    entity.UpdatePosition(e.CenterX, e.CenterY)
                }
            }
            for each (e in pk.Players) {
                entity = this.GetEntity(e.RuntimeID)
                if (entity != null) {
                    entity.UpdatePosition(e.CenterX, e.CenterY)
                }
            }
        }

        private function onKeyDown(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.SPACE) {
                this.core.getPacketWriter().WritePacket(new PlaneFighterPlayerEvent(PlaneFighterPlayerEvent.StartFire, 0))
            }

        }

        private function onKeyUp(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.SPACE) {
                this.core.getPacketWriter().WritePacket(new PlaneFighterPlayerEvent(PlaneFighterPlayerEvent.StopFire, 0))
            }
        }
    }
}
