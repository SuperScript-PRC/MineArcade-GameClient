package MineArcade.utils {
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    /**
     * 加载材质（加载图像）。
     * @param filename 文件路径名
     * @param as_name 
     * @return Promise<as_name:String, content:Bitmap>
     */
    public function LoadTexture(filename:String, as_name:* = undefined):LPromise {
        return new LPromise(function(ok:Function):void {
            var loader:Loader = new Loader();
            loader.load(new URLRequest(filename));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                ok(as_name, e.target.content)
            })
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
                trace("TextureLoader: texture " + filename + " load error: " + e.text)
            })
        })
    }

}
