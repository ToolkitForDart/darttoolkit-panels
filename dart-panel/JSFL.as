/**
* Copyright (c) 2013, Adobe Systems Inc.
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are permitted provided 
* that the following conditions are met:
* - Redistributions of source code must retain the above copyright notice, this list of conditions and the 
*   following disclaimer.
* - Redistributions in binary form must reproduce the above copyright notice, this list of conditions and 
*   the following disclaimer in the documentation and/or other materials provided with the distribution.
* - Neither the name of Adobe Systems Inc. nor the names of its contributors may be used to endorse or 
*   promote products derived from this software without specific prior written permission.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
* PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR 
* ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
* INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR 
* TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
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