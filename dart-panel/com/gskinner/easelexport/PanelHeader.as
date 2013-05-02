package com.gskinner.easelexport {
	
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Quadratic;
	
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.ColorTransform;
	import flash.display.Graphics;
	import com.gskinner.controls.CS7HeaderButton;
	
	public class PanelHeader extends Sprite	{
		
		public static var TWEEN_DURATION:Number = .15;
		public static var PADDING:int = 10;
		
		protected var _title:String;
		protected var _isOpen:Boolean;
		
		public var arrowIcon:Sprite;
		protected var arrowTween:GTween;
		
		public var bg:CS7HeaderButton;
		public var titleText:TextField;
		
		protected var arrowBitmap:Bitmap;
		
		protected var _width:Number = 100;
		protected var _height:Number = 21;
		
		protected var _textColor:int = 0x0;
		protected var _color:int = 0xd2d2d2;
		protected var _useShading:Boolean = false;
		
		public function PanelHeader() {
			configUI();
			mouseChildren = false;
			FontManager.setupTextField(titleText, false, true);
		}
		
		protected function configUI():void {
			
			bg = new CS7HeaderButton();
			bg.height = 19;
			addChildAt(bg, 0);
			
			//Replace arrow with bitmap instance
			arrowBitmap = new Bitmap(new HeaderArrowBitmap());
			arrowIcon.removeChildAt(0);
			arrowIcon.addChild(arrowBitmap);
			arrowBitmap.x = -arrowBitmap.width >> 1;
			arrowBitmap.y = -arrowBitmap.height >> 1;
			
			arrowTween = new GTween(arrowIcon, TWEEN_DURATION, {}, {ease: Quadratic.easeOut, onComplete: onTweenComplete});
		}
		
		public function get isOpen():Boolean { return _isOpen; }
		public function set isOpen(value:Boolean):void {
			if(value == _isOpen){ return; }
			_isOpen = value;
			arrowTween.proxy.rotation = (value)? 90 : 0;
			arrowBitmap.smoothing = true;
		}
		
		public function set title(value:String):void {
			if (!value){ return; }
			_title = value;//.toLocaleUpperCase();
			titleText.text = _title;
		}
		
		//Ignore height
		override public function set height(value:Number):void { 
			return; 
		}
		
		//width only affects bg and titleText
		override public function set width(value:Number):void {
			if (value != _width) {
				_width = value;
				bg.width = value;
				titleText.width = value - titleText.x - PADDING;
			}
		}
				
		public function set textColor(value:int):void {
			if (value != _textColor) {
				_textColor = value;
				var tf:TextFormat = titleText.getTextFormat();
				tf.color = _textColor;
				titleText.setTextFormat(titleText.defaultTextFormat=tf);
			}
		}
						
		protected function onTweenComplete(tween:GTween):void {
			arrowBitmap.smoothing = false;
		}

	}
}