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
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import fl.controls.BaseButton;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	public class CS7Button extends BaseButton {
		
		public function CS7Button() {
			super();
		}
		
		/**
         * @private
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
		private static var defaultStyles:Object = {
			themePanelHeaderBackground: 0xD6D6D6,
			themePanelHeaderBorder: 0x585858,
			themePanelHeaderBorderBevel: 0xCDCDCD,

			themeControlFocus:0x007CDB,
			themeStaticTextNormalColor: 0x000000,
			
			themeControlFocus: 0x007CDB,
			themeControlBorderNormal: 0x000000,
			themeControlBorderDisabled: 0x000000,
			
			themeControlFillTopNormal: 0xC0C0C0,
			themeControlFillBottomNormal: 0xD9D9D9,
			themeControlFillTopOver: 0xCCCCCC,
			themeControlFillBottomOver: 0xEAEAEA,
			themeControlFillTopDown: 0xB3B3B3,
			themeControlFillBottomDown: 0x999999,
			themeControlFillTopDisabled: 0xD2D2D2,
			themeControlFillBottomDisabled: 0xD2D2D2,
			themeControlFillTopSelectedOver: 0xC0C0C0,
			themeControlFillBottomSelectedOver: 0xA6A6A6,
			
			themeControlFillNormal: 0xC3C3C3,
			themeControlFillOver: 0xD1D1D1,
			themeControlFillDown: 0xBCBCBC,
			themeControlFillDisabled: 0xD2D2D2,
			themeControlFillSelectedOver: 0xB3B3B3,
			themeEnableShading:true
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
		
		override public function drawFocus(focused:Boolean):void {
			if (uiFocusRect != null && contains(uiFocusRect)) {
				removeChild(uiFocusRect);
				uiFocusRect = null;
			}

			if (focused) {
				uiFocusRect = new Sprite();
				var focusPadding:Number = getStyleValue('focusRectPadding') as Number;
				var g:Graphics = (uiFocusRect as Sprite).graphics;

				g.lineStyle(0, getStyleValue('themeControlFocus') as uint);
				
				g.drawRect(-focusPadding, -focusPadding, width+(focusPadding*2), height+(focusPadding*2));
				
				addChildAt(uiFocusRect, 0);
			}
		}

		override protected function drawBackground():void {
			// do nothing
			var newMouseState:String = (mouseState == 'up') ? 'normal' : mouseState;
			var themeState:String = enabled ? newMouseState : 'disabled';
			themeState = themeState.substr(0,1).toUpperCase()+themeState.substr(1);
			var useShading:Boolean = getStyleValue('themeEnableShading') || false;
			if (selected) { themeState = "Selected"+themeState; }
			
			var borderColor:uint = getStyleValue('themeControlBorder'+themeState) as uint;
			var fillColors:Array = [];
			
			// RM: colors are backwards?
			fillColors[0] = useShading ? getStyleValue('themeControlFillBottom'+themeState) : getStyleValue('themeControlFill'+themeState);
			fillColors[1] = useShading ? getStyleValue('themeControlFillTop'+themeState) : getStyleValue('themeControlFill'+themeState);
			
			var m:Matrix = new Matrix();
			m.createGradientBox(width, height, (Math.PI/180)*90, 0, 0);
			
			var g:Graphics = graphics;
			g.clear();			
			
			g.lineStyle(0, borderColor, 1, true)//, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.BEVEL);
			g.beginGradientFill(GradientType.LINEAR, fillColors, [1,1], [0, 255], m);
			
			g.drawRect(0, 0, width, height);
			g.endFill();
			
		}
		
		override protected function drawLayout():void {
			// do nothing
			
		}

	}
	
}
