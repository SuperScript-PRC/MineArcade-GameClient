package MineArcade.arcades.public_minearea {
    import MineArcade.core.CorArcade;
    import MineArcade.core.Main;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.protocol.packets.arcade.StartGame;
    import MineArcade.define.GameType;
    import MineArcade.utils.AsyncGather;

    public function Entry(core:CorArcade):void {
        MineBlocks.Init()
        AsyncGather([Textures.LoadBlockTextures(),
            Textures.LoadItemTextures()]).last(function():void {
                core.getPacketWriter().WritePacket(new StartGame(GameType.PUBLIC_MINEAREA, ""))
                var map:MineAreaMap = new MineAreaMap(Main.GCore)
                map.AddPlayer(core.getUserData().nickname, core.getUserData().uid, 0, 0, true)
                StageMC.root.addChild(map)
                map.Entry()
            })
    }
}
