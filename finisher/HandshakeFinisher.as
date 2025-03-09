package finisher {
    import mcs_getter.StageMC;
    import auth.Handshake;
    import messages.top_message
    import gui.SimpleWindow
    import core.CorArcade;

    public class HandshakeFinisher {
        public function HandshakeFinisher(cor:CorArcade, ok_cb:Function) {
            var handshake:Handshake = new Handshake(cor.getPacketWriter(), cor.getPacketHander());
            cor.getConnection().hookConnectionListener(function():void {
                handshake.sendHandshake(function(success:Boolean, msg:String):void {
                    if (success) {
                        top_message.show("登录已就绪")
                        ok_cb()
                    } else {
                        trace("[error] handshake: " + msg)
                        SimpleWindow.error("连接失败: " + msg, 400, 200, function():void {
                            StageMC.root.gotoAndPlay(1, "Preload")
                        })
                        cor.getConnection().close()
                    }
                })
            });
            cor.getConnection().hookDisconnectionListener(function():void {
                SimpleWindow.error("连接断开", 400, 200, function():void {
                    StageMC.root.gotoAndPlay(1, "Preload")
                })
                cor.getConnection().close()
            })
            cor.getConnection().hookErrorListener(function(err:String):void {
                SimpleWindow.error("连接错误: " + err, 400, 200, function():void {
                    StageMC.root.gotoAndPlay(1, "Preload")
                })
                cor.getConnection().close()
            })
            cor.getConnection().setListeners()
            top_message.show("正在连接到服务器..")
            cor.getConnection().ConnectServer()
        }
    }
}
