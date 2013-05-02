package com.gskinner.easelexport
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class DashedUnderline extends Sprite
	{
		protected static var tileData:BitmapData;
		public var textField:TextField;
		
		protected static var _color:uint=0xAA0771C4
		
		public function DashedUnderline(textField:TextField){
			if (!tileData) {
				tileData = new BitmapData(2,1,true,0);
				tileData.setPixel32(0, 0, _color);
			}
			
			this.textField = textField;
			textField.parent.addChild(this);
			textField.addEventListener(Event.CHANGE, onTextChanged, false, 0, true);
			update();
		}
		
		public static function set color(value:uint):void {
			
			if (value != _color) {
				if (tileData) {
					tileData.dispose();
					tileData = null;
				}
				
				var msk:uint = 0xFF000000;
				_color = (msk |= value);
				
				if (!tileData){
					tileData = new BitmapData(2,1,true,0);
					tileData.setPixel32(0,0,_color);
				}
				
			}
		}
		
		protected function onTextChanged(event:Event):void {
			update();
		}
		
		public function update():void {
			x = textField.x + 2;
			y = textField.y + textField.textHeight -1;
			width = Math.min(textField.textWidth, textField.width);
		}
		
		override public function set width(value:Number):void {
			graphics.clear();
			graphics.beginBitmapFill(tileData);
			graphics.drawRect(0, 0, value, 1);
		}
	}
}