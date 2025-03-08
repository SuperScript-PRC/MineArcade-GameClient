package net_connection {
    import protocol.Connection;
    import protocol.PacketHandler;
    import protocol.Writer;
    import mcs_getter.StageMC;
    import auth.Handshake;
    import messages.top_message
    import gui.SimpleWindow

    public class Starter {
        public function Starter() {
            var conn:Connection = new Connection("127.0.0.1", 6000);
            var hdl:PacketHandler = new PacketHandler(conn.socket);
            var writer:Writer = new Writer(conn.socket);
            var handshake:Handshake = new Handshake(writer, hdl);
            conn.hookHandler(hdl);
            conn.hookConnectionListener(function():void {
                handshake.sendHandshake(function(success:Boolean, msg:String):void {
                    if (success) {
                        top_message.show("登录已就绪")
                    } else {
                        trace("[error] handshake: " + msg)
                        SimpleWindow.error("连接失败: " + msg, 400, 200, function():void {
                            StageMC.stage.gotoAndPlay(1, "Preload")
                        })
                        conn.removeListeners()
                    }
                })
            });
            conn.hookDisconnectionListener(function():void {
                SimpleWindow.error("连接断开", 400, 200, function():void {
                    StageMC.stage.gotoAndPlay(1, "Preload")
                })
                conn.removeListeners()
            })
            conn.hookErrorListener(function(err:String):void {
                SimpleWindow.error("连接错误: " + err, 400, 200, function():void {
                    StageMC.stage.gotoAndPlay(1, "Preload")
                })
                conn.removeListeners()
            })
            conn.setListeners()
            top_message.show("正在连接到服务器..")
        }
    }
}
