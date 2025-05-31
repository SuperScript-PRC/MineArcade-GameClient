package MineArcade.finisher {
    import MineArcade.core.CorArcade;
    import MineArcade.user.UserData;
    import MineArcade.gui.TipWindow;
    import MineArcade.core.Main;
    import MineArcade.protocol.packets.Pool;
    import MineArcade.utils.LPromise;
    import MineArcade.protocol.packets.lobby.PlayerBasics;

    public class UserDataFinisher {
        private var cor:CorArcade;

        public function UserDataFinisher(cor:CorArcade):void {
            this.cor = cor
        }

        /**
         * 获取用户数据
         * @return LPromise<UserData>
         */
        public function finishUserData():LPromise {
            var ok:Boolean = false;
            return cor.getPacketHander().waitForPacket(Pool.IDPlayerBasics, 20000).then(function(cb:Function, pk:PlayerBasics, ok:Boolean):void {
                if (ok) {
                    var ud:UserData = cor.getUserData()
                    ud.nickname = pk.Nickname
                    ud.uuid = pk.UUID
                    ud.money = pk.Money
                    ud.power = pk.Power
                    ud.points = pk.Points
                    ud.level = pk.Level
                    ud.exp = pk.Exp
                    ud.exp_upgrade = pk.ExpUpgrade
                    cb(true)
                } else {
                    cb(false)
                }
            }).then(function(ok:Function, res:Boolean):void {
                if (!res) {
                    TipWindow.error("无法获取用户数据", 500, 300, function():void {
                        Main.Exit()
                    })
                }
                ok(res)
            })
        }
    }
}
