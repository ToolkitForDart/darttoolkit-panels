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
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import fl.managers.StyleManager;
	import fl.controls.Button;
	import com.gskinner.controls.CS7Button;
	import flash.text.TextFormat;
	
	public class ThemeManager extends EventDispatcher {
		
		protected static var _instance:ThemeManager;
		
		protected var _params:Object;
		protected var _themes:Object;
		protected var _currentTheme:String='light';	
		
		public function ThemeManager(enforcer:SingletonEnforcer) {
			
			_params = {};

			_themes = {
				dark:{
				
					themeAppBackgroundColor: 0x424242,
					
					themeItemSelectedColor: 0x515151,
					themeItemHighlightedColor: 0x393939,
					themeHotTextNormalColor: 0xC69100,
					themeHotTextRolloverColor: 0xC6AC63,
					themeHotTextDisableColor: 0x686868,
					themeStaticTextNormalColor: 0XCCCCCC,/*0xFFFFFF,*/
					themeStaticTextDisableColor: 0x686868,
					themeTextEditNormalBackgroundColor: 0xA0A0A0,
					themeTextEditDisableBackgroundColor: 0x646464,
					
					themeDividerLine: 0x000000,
					themeDividerLineBevel: 0xFFFFFF,
					themeControlFocus: 0xC69100,
					themeControlBorderNormal: 0x000000,
					themeControlBorderDisabled: 0x000000,
					
					themeControlFillTopNormal: 0x3B3B3B,
					themeControlFillBottomNormal: 0x555555,
					themeControlFillTopOver: 0x414141,
					themeControlFillBottomOver: 0x606060,
					themeControlFillTopDown: 0x303030,
					themeControlFillBottomDown: 0x2F2F2F,
					themeControlFillTopDisabled: 0x424242,
					themeControlFillBottomDisabled: 0x424242,
					themeControlFillTopSelectedOver: 0x484848,
					themeControlFillBottomSelectedOver: 0x373737,
					themeGenericIconNormal: 0xADADAD,/*0xFFFFFF,*/
					themeGenericIconShadowNormal: 0x000000,
					themeGenericIconDisabled: 0x686868,
					themeGenericIconShadowDisabled: 0x686868,
					
					themeControlFillNormal: 0x484848,
					themeControlFillOver: 0x505050,
					themeControlFillDown: 0x303030,
					themeControlFillDisabled: 0x424242,
					themeControlFillSelectedOver: 0x404040,
					themeUseGradients:false,
					
					/* Custom */
					themePanelHeaderBackground: 0x474747,
					themePanelHeaderBorder: 0x070707,
					themePanelHeaderBorderBevel: 0x454545,
					
					themeScrollTrackBorder: 0x1A1A1A,
					themeScrollTrackBorderBevel: 0x333333,
					themeScrollTrackBackgroundColor: 0x383838,
					
					themeScrollThumbBorder: 0x070707,
					themeScrollThumbBorderBevel: 0x505050,
					themeScrollThumbFillNormal: 0x424242,
					themeScrollThumbFillOver: 0x525252,
					themeScrollThumbFillDown: 0x2E2E2E,
					
					themeScrollArrowBorder: 0x070707,
					themeScrollArrowBorderBevel: 0x464646,
					themeScrollArrowFillNormal: 0x383838,
					themeScrollArrowFillOver: 0x494949,
					themeScrollArrowFillDown: 0x3C3C3C
				},
				
				light: {
					themeAppBackgroundColor: 0xCDCDCD,
					themeItemSelectedColor: 0xBDBDBD,
					themeItemHighlightedColor: 0xDCDCDC,
					themeHotTextNormalColor: 0x007CDB,
					themeHotTextRolloverColor: 0x6EACDB,
					themeHotTextDisableColor: 0x909090,
					themeStaticTextNormalColor: 0x000000,
					themeStaticTextDisableColor: 0x909090,
					themeTextEditNormalBackgroundColor: 0xEDEDED,
					themeTextEditDisableBackgroundColor: 0xD4D4D4,
					themeDividerLine: 0x000000,
					themeDividerLineBevel: 0xFFFFFF,
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
					themeGenericIconNormal: 0x000000,
					themeGenericIconShadowNormal: 0xFFFFFF,
					themeGenericIconDisabled: 0x909090,
					themeGenericIconShadowDisabled: 0x909090,
					
					themeControlFillNormal: 0xC3C3C3,
					themeControlFillOver: 0xD1D1D1,
					themeControlFillDown: 0xBCBCBC,
					themeControlFillDisabled: 0xD2D2D2,
					themeControlFillSelectedOver: 0xB3B3B3,
					themeUseGradients:false,
					
					/* Custom */
					themePanelHeaderBackground: 0xD6D6D6,
					themePanelHeaderBorder: 0x585858,
					themePanelHeaderBorderBevel: 0xCDCDCD,
					
					themeScrollTrackBorder: 0x757575,
					themeScrollTrackBorderBevel: 0xA8A8A8,
					themeScrollTrackBackgroundColor: 0xBCBCBC,
					
					themeScrollThumbBorder: 0x585858,
					themeScrollThumbBorderBevel: 0xE5E5E5,
					themeScrollThumbFillNormal: 0xD2D2D2,
					themeScrollThumbFillOver: 0xD0D0D0,
					themeScrollThumbFillDown: 0xA6A6A6,
					
					themeScrollArrowBorder: 0x1A1A1A,
					themeScrollArrowBorderBevel: 0xA8A8A8,
					themeScrollArrowFillNormal: 0xBCBCBC,
					themeScrollArrowFillOver: 0xE5E5E5,
					themeScrollArrowFillDown: 0xAFAFAF
				}
			}
			
		}
		
		public function set currentTheme(value:String):void {
			if (value != _currentTheme) {
				_currentTheme = value;
				
				var theme:Object = _themes[_currentTheme];
				for (var n:String in theme) {
					StyleManager.setStyle(n, theme[n]);
				}
			}
		}
		
		public function getParam(value:String):* {
			return _params[value] || _themes[_currentTheme][value];
		}
				
		public function updateTheme():void {
						
			var params:String = JSFL.call('getThemeColorParameters') || '';
			var param:String;
			var strValue:String;
			var clrValue:uint;
			var list:Array = params.split(',');
			
			//JSFL._trace(params);
			
			for (var i:int=0, l:int=list.length; i<l; i++) {
				param = list[i];
				strValue = JSFL.call('getThemeColor', param) || '';
				//JSFL._trace(param, strValue);				
				if (param == 'themeEnableShading') {
					_params[param] = (strValue == 'true');
					_themes[_currentTheme][param] = (strValue == 'true');
					StyleManager.setStyle(param, _params[param]);
				} else {
					if (param == 'themeAppBackgroundColor') { currentTheme = (strValue == '#424242') ? 'dark' : 'light'; }
					clrValue = parseInt( strValue.replace('"').replace('#',''), 16);
					_params[param] = clrValue;
				}
				
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
															
		
		/* static interface */
		public static function getInstance():ThemeManager {
			return _instance ||= new ThemeManager(new SingletonEnforcer);
		}
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0,  weakReference:Boolean=true):void {			
			getInstance().addEventListener(type, listener, useCapture, priority, weakReference);
		}
				
		static function removeEventListener(type:String, listener:Function):void {
			getInstance().removeEventListener(type, listener);
		}
		
		public static function getParam(value:String):* {
			return getInstance().getParam(value);
		}
		
		public static function updateTheme():void {
			getInstance().updateTheme();
		}
		
		public static function set currentTheme(value:String):void {
			getInstance().currentTheme = value;
		}

		public static function cloneTextFormat(o:TextFormat):TextFormat {
	        var tf:TextFormat = new TextFormat(
	        	o.font,
	        	o.size,
	        	o.color,
	        	o.bold,
	        	o.italic,
	        	o.underline,
	        	o.url,
	        	o.target,
	        	o.align,
	        	o.leftMargin,
	        	o.rightMargin,
	        	o.indent,
	        	o.leading
	        	);

	        return tf;
	    }

	    public static function average(a:Number, b:Number):Number {
			return ( (((a ^ b) & 0xFFFEFEFE) >> 1) + (a & b) );
		}

				
	}	
	
}

internal class SingletonEnforcer {	}