package MineArcade.user {

    import MineArcade.core.CorArcade;

    public class UserData {
        public var uid:String;
        public var nickname:String;
        public var password:String;
        public var money:Number;
        public var power:Number;
        public var points:Number;
        public var level:Number;
        public var exp:Number;
        public var exp_upgrade:Number;
        private var cor:CorArcade;

        public function UserData(cor:CorArcade) {
            this.cor = cor;
        }
    }
}
