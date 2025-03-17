package MineArcade.protocol.packets {
    import flash.net.Socket;

    public interface ClientPacket {
        function ID():int;
        function Marshal(w:Socket):void;
    }
}
