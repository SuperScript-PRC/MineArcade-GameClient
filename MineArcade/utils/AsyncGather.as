package MineArcade.utils {
    public function AsyncGather(ok_cb:Function, ... funcs:Array):void {
        const all_ok_num:int = funcs.length
        var ok_num:int = 0
        for each (var func:Function in funcs) {
            func(function():void {
                ok_num++
                if (ok_num == all_ok_num)
                    ok_cb()
            })
        }
    }
}
