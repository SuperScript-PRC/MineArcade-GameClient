package MineArcade.utils {
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;

    public class TextureLoader {
        public static function loadTexture(name:String, ok:Function):void {
            var loader:Loader = new Loader();
            loader.load(new URLRequest(name));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                ok(loader)
            })
        }
    }
}
