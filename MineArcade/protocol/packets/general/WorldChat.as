package MineArcade.protocol.packets.general {
    import MineArcade.protocol.GamePlayer;
    import MineArcade.protocol.packets.ServerPacket;
    import MineArcade.protocol.packets.Pool;

    public class WorldChat {
        public var ChatPlayer:GamePlayer
        public var Message:String

        public function WorldChat(ChatPlayer:GamePlayer = undefined, Message:String = undefined):void {
            this.ChatPlayer = ChatPlayer
            this.Message = Message
        }

        public function ID():int {
            return Pool.IDWorldChat
        }
    }
}
