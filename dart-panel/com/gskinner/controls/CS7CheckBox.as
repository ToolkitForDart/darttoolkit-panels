package com.gskinner.controls {

	import fl.controls.CheckBox;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;

	public class CS7CheckBox extends CheckBox {
		
		public static var ICON_SIZE:int = 11;

		protected var selectIcon:Sprite;
		
		/**
		 * @private
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		private static var defaultStyles:Object = {	
			textPadding: 0, 	
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
			themeGenericIconNormal: 0x000000,
			themeGenericIconShadowNormal: 0xFFFFFF,
			themeGenericIconDisabled: 0x909090,
			themeGenericIconShadowDisabled: 0x909090,
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
		public static function getStyleDefinition():Object
		{
			return mergeStyles(defaultStyles, CheckBox.getStyleDefinition());
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
				
				g.drawRect(icon.x-focusPadding, icon.y-focusPadding, ICON_SIZE+(focusPadding*2), ICON_SIZE+(focusPadding*2));
				
				addChildAt(uiFocusRect, 0);
			}
		}

		override protected function drawIcon():void
		{

			if (! icon) {
				icon = new Sprite();
				addChildAt(icon,1);
			}
			
			if (!selectIcon) {
				selectIcon = new SelectedIcon();
				selectIcon.x = 2.5;
				selectIcon.y = 0;
				(icon as Sprite).addChild(selectIcon);
			}
			
			var ctf:ColorTransform = selectIcon.transform.colorTransform;
			ctf.color = getStyleValue('themeGenericIconNormal') as uint;
			selectIcon.transform.colorTransform = ctf;
			
			var newMouseState:String = (mouseState == 'up') ? 'normal':mouseState;
			var themeState:String = enabled ? newMouseState:'disabled';
			themeState = themeState.substr(0,1).toUpperCase() + themeState.substr(1);
			var useShading:Boolean = getStyleValue('themeEnableShading') || false;
			selectIcon.visible = selected;

			var borderColor:uint = getStyleValue('themeControlBorder'+themeState) as uint;
			var fillColors:Array = [];

			// RM: colors are backwards?
			fillColors[0] = useShading ? getStyleValue('themeControlFillBottom'+themeState) : getStyleValue('themeControlFill'+themeState);
			fillColors[1] = useShading ? getStyleValue('themeControlFillTop'+themeState) : getStyleValue('themeControlFill'+themeState);

			var m:Matrix = new Matrix();
			m.createGradientBox(ICON_SIZE, ICON_SIZE, (Math.PI/180)*90, 0, 0);

			var g:Graphics = (icon as Sprite).graphics;
			g.clear();
			
			g.lineStyle(0, borderColor, 1, true);//, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.BEVEL);
			g.beginGradientFill(GradientType.LINEAR, fillColors, [1,1], [0, 255], m);

			g.drawRect(0, 0, ICON_SIZE, ICON_SIZE);
			g.endFill();

		}

	}

}