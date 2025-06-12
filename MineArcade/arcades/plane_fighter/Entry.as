package MineArcade.arcades.plane_fighter {
    import MineArcade.core.CorArcade;
    import MineArcade.utils.LPromise;
    import MineArcade.protocol.packets.arcade.StartGame;
    import MineArcade.define.GameType;

    public function Entry(core:CorArcade):void {
        Entities.LoadTextures(core).andThen(function():LPromise {
            return SFX.LoadSFX()
        }).last(function():void {
            core.getPacketWriter().WritePacket(new StartGame(GameType.PLANE_FIGHTER, ""))
            const stage:PFStage = new PFStage(core);
        })
    }
}
