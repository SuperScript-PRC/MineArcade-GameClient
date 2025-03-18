package MineArcade.utils
{
    public function getDictLen(d: Object):int{
        var len:int = 0;
        for (var k:String in d) len++;
        return len;
    }
}