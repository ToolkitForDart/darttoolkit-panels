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
package  {
	
	import fl.managers.StyleManager;
	import flash.text.TextFormat;
	import flash.system.Capabilities;
	import Locale;
	import flash.display.DisplayObjectContainer;
	import fl.controls.CheckBox;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.display.DisplayObject;
	
	public class FontManager {
		
	// Constants:
		public static const SANS_FONT:String = "_sans";
		
	// Public Properties:
		public static var font:String;
		public static var titleFont:String;
		public static var titleSize:Number;
		public static var titleBold:Boolean;
		public static var embed:Boolean;
		public static var fontThickness:uint;
		public static var fontSharpness:uint;
		public static var isWindows:Boolean;
		
	// Protected Properties:
		
	// Initialization:
		public function FontManager() {}
		
	// Public getter / setters:
	
		
	// Public Methods:
		public static function init(macFont, macTitleFont, winFont, winTitleFont) {
			//Determine correct font
			embed = Locale.get("EJS_UI_EMBEDFONT") == "true";
			isWindows = Capabilities.os.toLocaleLowerCase().indexOf("windows") != -1;
			
			font = isWindows ? winFont : macFont;
			titleFont = isWindows ? winTitleFont : macTitleFont;
			titleSize = 11;//(isWindows) ? 9 : 10.5;
			if (!embed) { font = titleFont = SANS_FONT; }
			titleBold = (font == titleFont);
			
			fontThickness = (isWindows) ? 0 : 100;
			fontSharpness = (isWindows) ? 200 : 100;
			
			var format:TextFormat = new TextFormat();
			format.size = 11;
			format.font = font;
			format.color = 0x262626;
			
			StyleManager.setStyle("embedFonts", (embed)? true : false); 
			StyleManager.setStyle("textFormat", format);
			StyleManager.setComponentStyle(CheckBox, "textPadding", 10);
		}
		
		public static function setupContainer(container:DisplayObjectContainer, noEmbedFlds:Object=null, titleFlds:Object=null) {
			var f:TextFormat;
			var tf:TextField;
			for (var i:int = 0, l:int = container.numChildren; i < l; i++){
				tf = container.getChildAt(i) as TextField;
				if (tf) {
					setupTextField(tf, noEmbedFlds && noEmbedFlds[tf.name], titleFlds && titleFlds[tf.name]);
				} else {
					var c:DisplayObject = container.getChildAt(i) as DisplayObject;
					if ("textField" in c){
						setupTextField(c["textField"], false, false);
						if ("drawNow" in c) {
							c["drawNow"](); // force redraw after the font is changed.
						}
					}
				}
			}
		}
		
		public static function setupTextField(tf:TextField, noEmbed:Boolean, title:Boolean=false) {
			var f:TextFormat = tf.defaultTextFormat;
			tf.embedFonts = !noEmbed && embed;
			if (noEmbed) {
				f.font = SANS_FONT;
			} else {
				f.font = font;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				if (!title) {
					tf.sharpness = fontSharpness;
					tf.thickness = fontThickness;
				}
			}
			if(title){
				f.font = titleFont;
				f.bold = titleBold;
				f.size = titleSize;
				
				//Tweaks for perfection...
				if (isWindows){
					tf.sharpness = 100;
					tf.thickness = -100;
				}
			}
			tf.setTextFormat(f);
			tf.defaultTextFormat = f;
		}
		
	
		
	// Protected Methods:
		
	}
	
}