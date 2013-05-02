package com.gskinner.controls {
	
	import fl.controls.BaseButton;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	
	public class CS7ScrollBarDownArrow extends BaseButton {
		
		protected var arrowIcon:Sprite;
		
		/**
         * @private
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
		private static var defaultStyles:Object = {
			themeScrollTrackBorder: 0x757575,
			themeScrollTrackBorderBevel: 0xA8A8A8,
			themeScrollTrackBackgroundColor: 0xBCBCBC,
			
			themeScrollArrowBorder: 0x1A1A1A,
			themeScrollArrowBorderBevel: 0xA8A8A8,
			themeScrollArrowFillNormal: 0xBCBCBC,
			themeScrollArrowFillOver: 0xE5E5E5,
			themeScrollArrowFillDown: 0xAFAFAF,
			
			themeGenericIconNormal: 0x000000,
			themeGenericIconShadowNormal: 0xFFFFFF
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
		
		override protected function configUI():void {
			super.configUI();
			
			addChild(arrowIcon = new ArrowIcon());
			arrowIcon.rotation = 180;
		}
		
		override protected function drawBackground():void {
			// do nothing
		}
		
		override protected function drawLayout():void {
			
			// track
			var fillColor:uint = getStyleValue('themeScrollTrackBackgroundColor') as uint;
			var borderColor:uint = getStyleValue('themeScrollTrackBorder') as uint;
			var innerBorder:uint = getStyleValue('themeScrollTrackBorderBevel') as uint;
						
			var g:Graphics = graphics;
			g.clear();
			
			g.beginFill(borderColor);			
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			g.beginFill(innerBorder);			
			g.drawRect(1, 0, width-1, height-1);
			g.endFill();			
			
			g.beginFill(fillColor);
			g.drawRect(2, 0, width-2, height-2);
			g.endFill();
			
			
			// button / arrow
			
			arrowIcon.x = width / 2;
			arrowIcon.y = height / 2;
			
			var ctf:ColorTransform = arrowIcon.transform.colorTransform;
			ctf.color = getStyleValue('themeGenericIconNormal') as uint;
			arrowIcon.transform.colorTransform = ctf;
			
			var newMouseState:String = (mouseState == 'up') ? 'normal' : mouseState;			
			
			if (newMouseState == 'over') {
				var themeState:String = enabled ? newMouseState : 'disabled';
				themeState = themeState.substr(0,1).toUpperCase()+themeState.substr(1);
				fillColor = getStyleValue('themeScrollArrowFill'+themeState) as uint;
				borderColor = getStyleValue('themeScrollArrowBorder') as uint;
				innerBorder = getStyleValue('themeScrollArrowBorderBevel') as uint;
				
				//borderColor = 0xff0000;
				//g.beginFill(borderColor);
				//g.drawRect(0, 0, width, height);
				//g.endFill();
				
				//innerBorder = 0x00ff00;
				//fillColor = 0x0000ff;
				g.lineStyle(0, innerBorder);
				g.beginFill(fillColor);
				g.drawRect(1, 1, width-2, height-3);
				g.endFill();
				
				g.lineStyle(0,0,0);
				g.beginFill(borderColor);
				g.drawRect(0, 0, width, 1);
				g.endFill();
			}			
			
		}

	}
	
}
