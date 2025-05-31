package MineArcade.finisher {
    import MineArcade.auth.Authentication;
    import MineArcade.core.CorArcade;
    import MineArcade.gui.TopMessage;
    import MineArcade.gui.TipWindow;
    import MineArcade.utils.LPromise;

    public class AuthFinisher {
        private var auth:Authentication;

        public function AuthFinisher(cor:CorArcade) {
            auth = new Authentication(cor);
        }

        /**
         * 完成登录
         * @param username
         * @param password
         * @return Promise<{success:Boolean, msg:String, status_code:int}>
         */
        public function finishAuth(username:String, password:String):LPromise {
            if (username.length > 20) {
                TipWindow.warning("用户名异常")
                return null
            }
            if (password.length > 20) {
                TipWindow.warning("密码异常")
                return null
            }
            return auth.Auth(username, password).then(function(ok:Function, success:Boolean, messgae:String, status_code:int):void {
                if (success) {
                    TopMessage.show("登录成功, 欢迎 " + username)
                } else {
                    TipWindow.error("登录失败: " + messgae, 500, 300)
                }
                ok(success, messgae, status_code)
            })
        }
    }
}
