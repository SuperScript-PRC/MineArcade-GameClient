package MineArcade.arcades.public_minearea {
    import MineArcade.core.CorArcade;
    import MineArcade.core.Main;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.protocol.packets.StartGame;
    import MineArcade.define.GameType;

    public function Entry(core:CorArcade):void {
        Blocks.Init()
        Textures.LoadBlockTextures(function():void{
            core.getPacketWriter().WritePacket(new StartGame(GameType.PUBLIC_MINEAREA, ""))
            map.Entry()
        })
        var map:MineAreaMap = new MineAreaMap(Main.GCore)
        map.AddPlayer(core.getUserData().nickname, core.getUserData().uuid, 0, 0, true)
        StageMC.root.addChild(map)
    }
}
