package com.gskinner.controls {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import fl.controls.BaseButton;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	
	public class CS7HeaderButton extends BaseButton {
		
		public function CS7HeaderButton() {
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
				
		override protected function drawBackground():void {
			// do nothing
		}
		
		override protected function drawLayout():void {
			var newMouseState:String = (mouseState == 'up') ? 'normal' : mouseState;
			var themeState:String = enabled ? newMouseState : 'disabled';
			themeState = themeState.substr(0,1).toUpperCase()+themeState.substr(1);
			var useShading:Boolean = getStyleValue('themeEnableShading') || false;
			if (selected) { themeState = "Selected"+themeState; }
			
			var borderColor:uint = getStyleValue('themePanelHeaderBorder') as uint;
			var fillColors:Array = [];
			
			// RM: colors are backwards?
			fillColors[0] = useShading ? getStyleValue('themeControlFillBottom'+themeState) : getStyleValue('themePanelHeaderBackground');
			fillColors[1] = useShading ? getStyleValue('themeControlFillTop'+themeState) : getStyleValue('themePanelHeaderBackground');


			var m:Matrix = new Matrix();
			m.createGradientBox(width, height, (Math.PI/180)*90, 0, 0);
			
			var g:Graphics = graphics;
			g.clear();			
			
			g.lineStyle(0, borderColor, 1, true)//, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.BEVEL);
			g.beginGradientFill(GradientType.LINEAR, fillColors, [1,1], [0, 255], m);
			
			g.drawRect(0, 0, width, height);
			g.endFill();
			
		}

	}
	
}
