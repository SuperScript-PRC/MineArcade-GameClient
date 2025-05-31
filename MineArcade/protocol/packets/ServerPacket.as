package MineArcade.protocol.packets {

    import flash.utils.ByteArray;

    public interface ServerPacket {
        function ID():int;
        function NetType():int;
        function Unmarshal(r:ByteArray):void;
    }
}
