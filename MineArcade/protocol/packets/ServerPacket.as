package MineArcade.protocol.packets {
    import flash.utils.ByteArray;

    public interface ServerPacket {
        function ID():int;
        function Unmarshal(w:ByteArray):void;
    }
}
