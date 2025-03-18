package MineArcade.utils {
    public function uuid4():String {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, repl_rule);
    }
}

function repl_rule(c:String, p:int, s:String):String {
    var r:int = Math.random() * 16 | 0, v:int = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
}
