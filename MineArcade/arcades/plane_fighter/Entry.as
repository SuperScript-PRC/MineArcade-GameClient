package MineArcade.arcades.plane_fighter {
    import MineArcade.core.CorArcade;

    public function Entry(core:CorArcade):void {
        Entities.InitAndLoadTextures(core).last(function():void{
            const stage:PFStage = new PFStage(core);
        })
    }
}
