package {
	
	import adobe.utils.MMExecute;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class JSFL {
		
		public static var isDebug:Boolean = (MMExecute("fl")=="");
		
		public static var SCRIPT_PATH:String = "DartJS/jsfl/main.jsfl"
		public static var DELIMITER:String = "\n";
		
		/*
		//For local testing. When set to true, run() will return null, and the command is traced.
		public var debug:Boolean;
		
		public function JSFL(debug:Object=null) {
			this.debug = (MMExecute("fl")=="");
		}
		*/
		
		public static function call(...rest):String {
			var params:Array = rest;
			var functionName:String = params.shift().toString();
			var args:Array = [];
			var l:Number = params.length;
			for (var i:Number=0; i<l; i++) {
				if (params[i] == undefined) { params[i] = ""; }
				else { params[i] = params[i].toString(); }
				args.push("'" + (params[i] as String).split("'").join("\'").split("\n").join("\\n") + "'");
			}
			var exe:String = "fl.runScript(fl.configURI + '"+SCRIPT_PATH+"', '"+functionName+"'";
			if (params.length > 0) {
				exe += ", "+args.join(",");
			}
			exe += ");";
			
			if(isDebug){ 
				trace(exe);
				return null; 
			} else {
				return MMExecute(exe);		
			}
		}
		
		public static function run(script:String):String {
			return MMExecute(script);
		}
		
		
		public static function deserialize(dataStr:String):Object {
			if (dataStr == null) { return null; }
			var arr:Array = dataStr.split(DELIMITER);
			if (arr[0] != "version") { return null; }
			var l:uint = arr.length;
			var o:Object = {};
			for (var i=0; i<l; i+=2) {
				o[arr[i]] = arr[i+1];
			}
			return o;
		}
		
		public static function serialize(o:Object):String {
			var arr:Array = ["version",0.1];
			for (var n:String in o) {
				if (n == "version") { continue; }
				arr.push(n);
				arr.push(String(o[n]));
			}
			return arr.join(DELIMITER);
		}
		
		public static function _trace(...strings:Array):void {
			var str:String = strings.join(", ");
			if (isDebug) { trace(str); return; }
			str = str.split("'").join("\'").split("\n").join("\\n");
			MMExecute("fl.trace('"+str+"');");
		}
		
	}
}