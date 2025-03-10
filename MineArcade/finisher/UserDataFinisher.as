package MineArcade.finisher {
    import flash.utils.setTimeout;
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.PacketIDs;
    import MineArcade.user.UserData;
    import MineArcade.gui.SimpleWindow;
    import MineArcade.mcs_getter.StageMC;

    public class UserDataFinisher {
        private var cor:CorArcade;

        public function UserDataFinisher(cor:CorArcade):void {
            this.cor = cor
        }

        public function finishUserData(ok_cb:Function):void {
            var ok:Boolean = false;
            cor.getPacketHander().addPacketListenerOnce(PacketIDs.IDPlayerBasics, function(pk:Object):void {
                var ud:UserData = cor.getUserData()
                ud.uuid = pk.UUID
                ud.nickname = pk.Nickname
                ud.money = pk.Money
                ud.power = pk.Power
                ud.level = pk.Level
                ud.exp = pk.Exp
                ud.exp_upgrade = pk.ExpUpgrade
                ok = true
                ok_cb()
            })
            setTimeout(function():void {
                if (!ok) {
                    SimpleWindow.error("无法获取用户数据", 500, 300, ok_cb = function():void {
                        StageMC.root.gotoAndStop(1, "Preload")
                    })
                }
            }, 20000)
        }
    }
}
