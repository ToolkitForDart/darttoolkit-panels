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