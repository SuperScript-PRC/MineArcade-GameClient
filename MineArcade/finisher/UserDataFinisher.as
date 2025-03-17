package MineArcade.finisher {
    import flash.utils.setTimeout;
    import MineArcade.core.CorArcade;
    import MineArcade.user.UserData;
    import MineArcade.gui.TipWindow;
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.core.Main;
    import MineArcade.protocol.packets.Pool;

    public class UserDataFinisher {
        private var cor:CorArcade;

        public function UserDataFinisher(cor:CorArcade):void {
            this.cor = cor
        }

        public function finishUserData(ok_cb:Function):void {
            var ok:Boolean = false;
            cor.getPacketHander().addPacketListenerOnceWithTimeout(Pool.IDPlayerBasics, function(pk:Object):void {
                var ud:UserData = cor.getUserData()
                ud.nickname = pk.Nickname
                ud.uuid = pk.UUID
                ud.money = pk.Money
                ud.power = pk.Power
                ud.points = pk.Points
                ud.level = pk.Level
                ud.exp = pk.Exp
                ud.exp_upgrade = pk.ExpUpgrade
                ok = true
                ok_cb()
            }, 20000, function():void {
                TipWindow.error("无法获取用户数据", 500, 300, ok_cb = function():void {
                    Main.Exit()
                })
            })

        }
    }
}
