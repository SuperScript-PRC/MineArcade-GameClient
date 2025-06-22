package MineArcade.stage.transition {
    import MineArcade.mcs_getter.StageMC;
    import flash.display.MovieClip;

    public function ClearStage():void {
        for (var i:int = StageMC.root.numChildren - 1; i >= 0; i--) {
            var elem:* = StageMC.root.getChildAt(i)
            if (!(elem is MovieClip))
                continue
            try {
                var is_transition:* = elem["isTransition"]
            } catch (e:Error) {
                is_transition = false;
            }
            if (is_transition == undefined || !is_transition) {
                StageMC.root.removeChildAt(i)
            }
        }
    }
}
