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
package com.gskinner.controls {
	
	import fl.controls.BaseButton;
	import flash.display.Graphics;
	
	public class CS7ScrollBarThumb extends BaseButton {

		public function CS7ScrollBarThumb() {
			// constructor code
		}
		
		/**
         * @private
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
		private static var defaultStyles:Object = {
			themeScrollTrackBorder: 0x757575,
			themeScrollTrackBorderBevel: 0xA8A8A8,
			
			themeScrollThumbBorder: 0x585858,
			themeScrollThumbBorderBevel: 0xE5E5E5,
			themeScrollThumbFillNormal: 0xD2D2D2,
			themeScrollThumbFillOver: 0xD0D0D0,
			themeScrollThumbFillDown: 0xA6A6A6
		  };
		  
        /**
         * @copy fl.core.UIComponent#getStyleDefinition()
         *
		 * @includeExample ../core/examples/UIComponent.getStyleDefinition.1.as -noswf
		 *
         * @see fl.core.UIComponent#getStyle()
         * @see fl.core.UIComponent#setStyle()
         * @see fl.managers.StyleManager
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         *  
         *  @playerversion AIR 1.0
         *  @productversion Flash CS3
         */
		public static function getStyleDefinition():Object { 
			return mergeStyles(defaultStyles, BaseButton.getStyleDefinition());
		}
				
		override protected function drawBackground():void {
			// do nothing
		}
		
		override protected function drawLayout():void {
			
			var newMouseState:String = (mouseState == 'up') ? 'normal' : mouseState;
			var themeState:String = enabled ? newMouseState : 'disabled';
			themeState = themeState.substr(0,1).toUpperCase()+themeState.substr(1);
			
			var fillColor:uint = getStyleValue('themeScrollThumbFill'+themeState) as uint;
			var borderColor:uint = getStyleValue('themeScrollThumbBorder') as uint;
			var innerBorder:uint = getStyleValue('themeScrollThumbBorderBevel') as uint;
						
			var g:Graphics = graphics;
			g.clear();
			
			g.beginFill(borderColor);			
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			g.lineStyle(0, innerBorder);
			g.beginFill(fillColor);
			g.drawRect(1, 1, width-2, height-3);
			g.endFill();
			
						
		}

	}
	
}
