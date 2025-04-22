package MineArcade.protocol.packets {

    import flash.utils.ByteArray;

    public interface ClientPacket {
        function ID():int;
        function Marshal(w:ByteArray):void;
    }
}
