package MineArcade.fixer {
    import flash.events.Event;
    import flash.display.DisplayObject;

    public function SafeListen(mc:DisplayObject, event:String, listener:Function):void {
        mc.addEventListener(event, listener)
        mc.addEventListener(Event.REMOVED_FROM_STAGE, listener)
    }
}
