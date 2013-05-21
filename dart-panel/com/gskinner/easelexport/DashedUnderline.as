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