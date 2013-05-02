package com.gskinner.controls {
	
	import fl.controls.BaseButton;
	import flash.display.Graphics;
	
	public class CS7ScrollBarTrack extends BaseButton {

		public function CS7ScrollBarTrack() {
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
			themeScrollTrackBackgroundColor: 0xBCBCBC
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
						
			var fillColor:uint = getStyleValue('themeScrollTrackBackgroundColor') as uint;
			var borderColor:uint = getStyleValue('themeScrollTrackBorder') as uint;
			var innerBorder:uint = getStyleValue('themeScrollTrackBorderBevel') as uint;
						
			var g:Graphics = graphics;
			g.clear();
			
			g.beginFill(borderColor);			
			g.drawRect(0, -1, width, height+1);
			g.endFill();
			
			g.lineStyle(0, innerBorder);
			g.beginFill(fillColor);
			g.drawRect(1, -1, width-2, height+1);
			g.endFill();
			
		}

	}
	
}
