package MineArcade.finisher
{
    import MineArcade.auth.Authentication;
    import MineArcade.core.CorArcade;
    import MineArcade.gui.TopMessage;
    import MineArcade.gui.TipWindow;

    public class AuthFinisher
    {
        private var auth_machine:Authentication;

        public function AuthFinisher(cor:CorArcade)
        {
            auth_machine = new Authentication(cor);
        }

        public function finishAuth(username:String, password:String, ok_cb:Function):void
        {
            auth_machine.Auth(username, password, function(success:Boolean, msg:String, status_code:int):void{
                if (success) {
                    TopMessage.show("登录成功, 欢迎 " + username)
                    ok_cb()
                } else {
                    TipWindow.error("登录失败: " + msg, 500, 300)
                }
            }
)
        }
    }
}