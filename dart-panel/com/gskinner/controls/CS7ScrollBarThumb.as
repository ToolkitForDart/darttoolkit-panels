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
