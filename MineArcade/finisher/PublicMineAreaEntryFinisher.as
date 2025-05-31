package MineArcade.finisher {
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.gui.TopMessage;
    import MineArcade.define.GameType;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.stage.transition.CutScene;
    import MineArcade.arcades.public_minearea.Entry;
    import MineArcade.utils.uuid4;
    import MineArcade.protocol.packets.lobby.ArcadeEntryResponse;
    import MineArcade.protocol.packets.lobby.ArcadeEntryRequest;

    public function PublicMineAreaEntryFinisher(core:CorArcade):void {
        var gen_uuid:String = uuid4()
        // core.getPacketHander().addPacketListenerOnceWithCondition(Pool.IDArcadeEntryResponse, function(pk:ArcadeEntryResponse):Boolean {
        //     if (pk.ResponseUUID == gen_uuid) {
        //         if (pk.Success) {
        //             CutScene.cutScene().then(function():Boolean {
        //                 StageMC.safeGotoAndStop(1, "PublicMineArea");
        //                 Entry(core)
        //                 return true
        //             })
        //             return true
        //         } else {
        //             TopMessage.show("加入游戏失败..")
        //         }
        //     }
        //     return false
        // }, 10000, function():void {
        //     TopMessage.show("加入游戏失败: 请求超时")
        // })
        core.getPacketWriter().WritePacket(new ArcadeEntryRequest(GameType.PUBLIC_MINEAREA, "", gen_uuid))
        core.getPacketHander().waitForPacket(Pool.IDArcadeEntryResponse, 10000).last(function(pk:ArcadeEntryResponse,ok:Boolean):Boolean {
            if (!ok) {
                TopMessage.show("加入游戏失败: 请求超时")
            } else if (pk.ResponseUUID == gen_uuid) {
                if (pk.Success) {
                    CutScene.cutScene().last(function():Boolean {
                        StageMC.safeGotoAndStop(1, "PublicMineArea");
                        Entry(core)
                        return true
                    })
                    return true
                } else {
                    TopMessage.show("加入游戏失败..")
                }
            }
            return false
        })
    }
}
