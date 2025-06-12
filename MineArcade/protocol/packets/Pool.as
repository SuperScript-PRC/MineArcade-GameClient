package MineArcade.protocol.packets
{
    import MineArcade.protocol.packets.general.*;
    import MineArcade.protocol.packets.lobby.*;
    import MineArcade.protocol.packets.arcade.plane_fighter.*;
    import MineArcade.protocol.packets.arcade.public_minearea.*;
    import MineArcade.protocol.packets.arcade.*;

    public class Pool {
        public static function GetServerPool():Object {
            var pool:Object = {}
            pool[PacketIDs.IDServerHandshake] = ServerHandshake
            pool[PacketIDs.IDClientLoginResp] = ClientLoginResp
            pool[PacketIDs.IDKickClient] = KickClient
            pool[PacketIDs.IDDialLagResp] = DialLagResp
            pool[PacketIDs.IDPlayerBasics] = PlayerBasics
            pool[PacketIDs.IDBackpackResponse] = BackpackResponse
            pool[PacketIDs.IDSimpleEvent] = SimpleEvent
            pool[PacketIDs.IDArcadeMatchJoinResp] = ArcadeMatchJoinResp
            pool[PacketIDs.IDArcadeMatchEvent] = ArcadeMatchEvent
            pool[PacketIDs.IDArcadeGameComplete] = ArcadeGameComplete
            pool[PacketIDs.IDPublicMineareaBlockEvent] = PublicMineareaBlockEvent
            pool[PacketIDs.IDPublicMineAreaChunk] = PublicMineAreaChunk
            pool[PacketIDs.IDPublicMineareaPlayerActorData] = PublicMineareaPlayerActorData
            pool[PacketIDs.IDArcadeEntryResponse] = ArcadeEntryResponse
            pool[PacketIDs.IDRankResponse] = RankResponse
            pool[PacketIDs.IDPlaneFighterPlayerList] = PlaneFighterPlayerList
            pool[PacketIDs.IDPlaneFighterAddActor] = PlaneFighterAddActor
            pool[PacketIDs.IDPlaneFighterActorEvent] = PlaneFighterActorEvent
            pool[PacketIDs.IDPlaneFighterStage] = PlaneFighterStage
            pool[PacketIDs.IDPlaneFighterTimer] = PlaneFighterTimer
            pool[PacketIDs.IDPlaneFighterScores] = PlaneFighterScores;
            pool[PacketIDs.IDPlaneFighterPlayerStatuses] = PlaneFighterPlayerStatuses
            return pool
        }
    }
}