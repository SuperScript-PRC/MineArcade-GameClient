package messages
{
    import messages._top_message_maker

    public class top_message
    {
        private static const maker: _top_message_maker = new _top_message_maker()

        public static function show(msg: String):void {
            maker._make_top_message(msg)
        }
    }
}