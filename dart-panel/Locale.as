package
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Locale
	{
		public static var onComplete:Function;
		public static var xml:XML;
		
		public static function load(url:String):void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadError, false, 0, true);
			loader.load(new URLRequest(url));	
		}
		
		protected static function onLoadError(event:IOErrorEvent):void {}
		
		protected static function loadComplete(event:Event):void {
			xml = new XML(event.target.data);
			if(onComplete != null){ onComplete(); }
		}
		
		public static function get(key:String, details:String=null):String {
			if (xml == null) { return "[ERROR: Locale data not loaded]"; }
			var str:String;
			var node:XMLList = xml.s.(@key==key);
			if (node.length()) {
				str = node[0].toString();
				if (details) { str = str.split("%DETAILS%").join(details); }
			} else { str = key; }
			return str;
		}
	}
}