package MineArcade.arcades.public_minearea {
    import MineArcade.core.CorArcade;
    import MineArcade.core.Main;
    import MineArcade.mcs_getter.StageMC;

    public function Entry(core:CorArcade):void {
        var map:MineAreaMap = new MineAreaMap(Main.GCore)
        StageMC.root.addChild(map)
    }
}
