package MineArcade.finisher {
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.auth.Handshake;
    import MineArcade.gui.TipWindow
    import MineArcade.gui.TopMessage
    import MineArcade.core.CorArcade;

    public class HandshakeFinisher {
        public function HandshakeFinisher(cor:CorArcade, ok_cb:Function) {
            var handshake:Handshake = new Handshake(cor.getPacketWriter(), cor.getPacketHander());
            cor.getConnection().hookConnectionListener(function():void {
                handshake.sendHandshake(function(success:Boolean, msg:String):void {
                    if (success) {
                        TopMessage.show("登录已就绪")
                        ok_cb()
                    } else {
                        trace("[error] handshake: " + msg)
                        TipWindow.error("连接失败: " + msg, 400, 200, function():void {
                            StageMC.root.gotoAndPlay(1, "Preload")
                        })
                        cor.getConnection().close()
                    }
                })
            });
            cor.getConnection().hookDisconnectionListener(function():void {
                TipWindow.error("连接断开", 400, 200, function():void {
                    StageMC.root.gotoAndPlay(1, "Preload")
                })
                cor.getConnection().close()
            })
            cor.getConnection().hookErrorListener(function(err:String):void {
                TipWindow.error("连接错误: " + err, 400, 200, function():void {
                    StageMC.root.gotoAndPlay(1, "Preload")
                })
                cor.getConnection().close()
            })
            cor.getConnection().setListeners()
            TopMessage.show("正在连接到服务器..")
            cor.getConnection().ConnectServer()
        }
    }
}
