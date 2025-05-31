package MineArcade.utils{

    public class LPromise {
        private var _actived:Boolean = false;
        private var _func_with_ok_cb:Function;
        private var _func_args:Array;
        private var _then_func:Function;
        private var _last_func:Function;

        /**
         * 创建一个 LPromise 对象。
         * @param func_with_ok_cb (ok_cb(result:Params):void, execute_now:Boolean=false)
         * 该函数在 LPromise 初始化的时候被执行，并传入 LPromise 自定义的 ok_cb。
         */
        function LPromise(func_with_ok_cb:Function, execute_now:Boolean = true) {
            this._func_args = [];
            this._func_with_ok_cb = func_with_ok_cb;
            if (execute_now)
                this.activate();
        }

        public function callback(...results):void {
            if (!this._actived)
                throw new Error("Call callback too fast")
            if (this._then_func is Function) {
                this._then_func.apply(null, results)
            } else if (this._last_func is Function) {
                this._last_func.apply(null, results)
            } else {
                trace("Warning: no callback function (then or last)")
            }
        }

        /**
         * @param (ok_cb:(...results:Params), args: Array)
         * @return LPromise[Params]
         */
        public function then(func:Function):LPromise {
            var pms:LPromise = new LPromise(func, false);
            var custom_callback:Function = function(...results):void {
                pms._func_args = results
                pms.activate()
            }
            this._then_func = custom_callback;
            return pms;
        }

        public function $then(cond:Function, func:Function):LPromise {
            var pms:LPromise = new LPromise(func, false);
            var custom_callback:Function = function(...results):void {
                if (!cond.apply(null, results)) return
                pms._func_args = results
                pms.activate()
            }
            this._then_func = custom_callback;
            return pms;
        }

        /**
         * 传入一个返回 LPromise 实例的函数，将其作为下一个 then 等的 LPromise 参数。
         * @param promise_func (promise_func:Function):LPromise
         * @return
         */
        public function andThen(promise_func:Function):LPromise {
            var p:LPromise = new LPromise(function(ok:Function):void {
            });
            var custom_callback:Function = function(...results):void {
                var p1:LPromise = promise_func.apply(null, results)
                p._func_with_ok_cb = p1._func_with_ok_cb
                p._func_args = p1._func_args
                p1.last(function(...results):void {
                    p.callback.apply(null, results)
                })
            }
            this._then_func = custom_callback;
            return p;
        }

        public function $andThen(cond:Function, promise_func:Function):LPromise {
            var p:LPromise = new LPromise(function(ok:Function):void {
            });
            var custom_callback:Function = function(...results):void {
                if (!cond.apply(null, results)) return
                var p1:LPromise = promise_func.apply(results)
                p._func_with_ok_cb = p1._func_with_ok_cb
                p._func_args = p1._func_args
                p1.last(function(...results):void {
                    p.callback.apply(null, results)
                })
            }
            this._then_func = custom_callback;
            return p;
        }

        /**
         *
         * @param func (...results):void
         */
        public function last(func:Function):void {
            this._last_func = func;
        }

        public function activate():void {
            this._actived = true;
            this._func_with_ok_cb.apply(null, [this.callback].concat(this._func_args))
        }
    }
}
