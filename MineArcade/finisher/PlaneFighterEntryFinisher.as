package MineArcade.finisher {
    import MineArcade.core.CorArcade;
    import MineArcade.define.GameType;
    import MineArcade.protocol.packets.lobby.ArcadeEntryRequest;
    import MineArcade.protocol.packets.lobby.ArcadeEntryResponse;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.gui.TopMessage;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.protocol.packets.arcade.ArcadeMatchJoin;
    import MineArcade.protocol.packets.arcade.ArcadeMatchJoinResp;
    import MineArcade.utils.LPromise;
    import MineArcade.protocol.packets.arcade.ArcadeMatchEvent;
    import MineArcade.arcades.plane_fighter.Entry;

    public class PlaneFighterEntryFinisher {
        public static function JoinGame(core:CorArcade):void {
            // 现在不能指定房间号等
            core.getPacketWriter().WritePacket(new ArcadeEntryRequest(GameType.PLANE_FIGHTER, "", ""))
            core.getPacketHander().waitForPacket(PacketIDs.IDArcadeEntryResponse, 10000).then(function(ok:Function, res:ArcadeEntryResponse, is_ok:Boolean):void {
                if (!is_ok) {
                    TopMessage.show("无法加入游戏: 加入超时")
                        // not need to call ok()
                } else if (!res.Success) {
                    TopMessage.show("无法加入游戏")
                } else {
                    ok()
                }
            }).last(function():void {
                StageMC.GoArcade("PlaneFighter")
            })
        }

        public static function GamemodeSelect(core:CorArcade, gamemode:int):void {
            // todo: 仍未支持多人游戏
            if (gamemode != 0) {
                TopMessage.show("暂无法选择多人游戏")
            }
            core.getPacketWriter().WritePacket(new ArcadeMatchJoin(GameType.PLANE_FIGHTER, gamemode, 0))
            core.getPacketHander().waitForPacket(PacketIDs.IDArcadeMatchJoinResp, 10000).then(function(ok:Function, res:ArcadeMatchJoinResp, is_ok:Boolean):void {
                if (!is_ok) {
                    TopMessage.show("无法加入游戏匹配: 加入超时")
                        // not need to call ok()
                } else if (!res.Success) {
                    TopMessage.show("无法加入游戏匹配: " + res.Message)
                }
                ok()
            })// .then(function():void {
            //     // todo: 我们先假定玩家在进行单人游戏
            // })
            .andThen(function():LPromise{
                // todo: 我们先假定玩家在进行单人游戏
                //       那么下一个匹配事件一定是匹配成功
                return core.getPacketHander().waitForPacket(PacketIDs.IDArcadeMatchEvent, 10000)
            }).then(function(ok:Function, res:ArcadeMatchEvent, is_ok:Boolean):void{
                if(!is_ok) {
                    TopMessage.show("无法加入游戏: 匹配超时")
                } else if(res.Action != ArcadeMatchEvent.ArcadeMatchEventReady) {
                    TopMessage.show("无法加入游戏: 匹配失败")
                } else {
                    TopMessage.show("匹配成功, 准备进入游戏")
                    ok()
                }
            }).andThen(function ():LPromise{
                return StageMC.GoArcade("PlaneFighter", 2);
            }).last(function():void{
                Entry(core);
            })
        }
    }
}
