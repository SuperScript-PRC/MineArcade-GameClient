package MineArcade.utils {
    public function AsyncGather(promises:Array):LPromise {
        return new LPromise(function(ok:Function):void {
            var ok_num:int = 0
            var total_num:int = promises.length
            for each (var promise:LPromise in promises) {
                promise.last(function(... _):void {
                    ok_num++
                    if (ok_num == total_num)
                        ok()
                })
            }
        })
    }
}
