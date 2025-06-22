package MineArcade.finisher {
    import MineArcade.core.CorArcade;
    import MineArcade.protocol.packets.arcade.ArcadeExitGame;
    import MineArcade.mcs_getter.StageMC;

    public class ExitGameFinisher {
        public static function ExitGameWithInterrupt(core:CorArcade):void {
            StageMC.GoArcade2("Main").last(function():void {
                core.getPacketWriter().WritePacket(new ArcadeExitGame())
            })
        }
    }
}
