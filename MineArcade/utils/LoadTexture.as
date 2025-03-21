package MineArcade.utils {
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public function LoadTexture(filename:String, ok:Function, as_name:*=undefined):void {
        var loader:Loader = new Loader();
        loader.load(new URLRequest(filename));
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
            ok(as_name, e.target.content)
        })
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
            trace("TextureLoader: texture " + filename + " load error: " + e.text)
        })
    }

}
