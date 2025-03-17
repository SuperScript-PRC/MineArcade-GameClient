package MineArcade.protocol.packets {
    import flash.net.Socket;

    public interface ServerPacket {
        function ID():int;
        function Unmarshal(w:Socket):void;
    }
}
