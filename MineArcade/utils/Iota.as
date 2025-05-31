package MineArcade.utils {

    public class Iota {
        private var _iota:int;

        function Iota() {
            _iota = 0;
        }

        public function iota(n:* = null):int {
            if (n is int) {
                return _iota = n;
            } else {
                return ++_iota;
            }
        }
    }
}
