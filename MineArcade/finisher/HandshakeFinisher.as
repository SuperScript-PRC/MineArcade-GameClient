package MineArcade.finisher {
    import MineArcade.mcs_getter.StageMC;
    import MineArcade.auth.Handshake;
    import MineArcade.gui.TipWindow
    import MineArcade.gui.TopMessage
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.PacketIDs;
    import MineArcade.protocol.packets.general.KickClient;
    import MineArcade.protocol.packets.general.UDPConnection;
    import MineArcade.protocol.packets.general.ServerHandshake;
    import flash.utils.setTimeout;

    /**
     * 完成服务端-客户端握手。
     * @param cor CorArcade
     * @param ok_cb 成功后执行的回调
     */
    public function HandshakeFinisher(cor:CorArcade, ok_cb:Function):void {
        var handshake:Handshake = new Handshake(cor.getPacketWriter(), cor.getPacketHander());
        cor.getTCPConnection().hookConnectionListener(function():void {
            handshake.sendHandshake().then(function(cb:Function, res:ServerHandshake, ok:Boolean):void {
                if (!ok) {
                    trace("[error] handshake: timeout")
                    TipWindow.error("连接失败: 连接超时", 400, 200, function():void {
                        StageMC.Restart()
                    })
                } else if (res.Success) {
                    TopMessage.show("登录已就绪")
                } else {
                    trace("[error] handshake: " + res.ServerMessage)
                    TipWindow.error("连接失败: " + res.ServerMessage, 400, 200, function():void {
                        StageMC.Restart()
                    })
                    cor.getTCPConnection().close()
                }
                setTimeout(cb, 10, res)
            }).$then(function(res:ServerHandshake):Boolean {
                return (res is ServerHandshake) && res.Success
            }, function(ok:Function, res:ServerHandshake):void {
                cor.getPacketWriter().WritePacket(new UDPConnection(res.VerifyToken))
                ok_cb()
            })
        });
        cor.getTCPConnection().hookDisconnectionListener(function():void {
            if (cor.getTCPConnection().connected)
                TipWindow.error("连接断开", 400, 200, function():void {
                    StageMC.Restart()
                })
            cor.getTCPConnection().close()
        })
        cor.getTCPConnection().hookErrorListener(function(err:String):void {
            TipWindow.error("连接错误: " + err, 400, 200, function():void {
                StageMC.Restart()
            })
            cor.getTCPConnection().close()
        })
        cor.getPacketHander().addPacketListenerOnce(PacketIDs.IDKickClient, function(p:KickClient):void {
            TipWindow.error("您已被踢出游戏: " + p.Message, 400, 200, function():void {
                StageMC.Restart()
            })
            cor.getTCPConnection().close()
        })
        cor.getTCPConnection().setListeners()
        cor.getUDPConnection().setListeners()
        TopMessage.show("正在连接到服务器..")
        cor.getTCPConnection().ConnectServer()
    }
}
