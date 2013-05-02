package com.gskinner.easelexport.panels {
	
	import fl.controls.CheckBox;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class TimelinePanel extends BaseSlidingPanel {
		
		public var loopCheck:CheckBox;
		public var exportImageCheck:CheckBox;
		public var bg:Sprite;
		
		public function TimelinePanel(){
			super();
			
			addEventListener(Event.RENDER, configUI);
			
		}
		
		protected function configUI(evt:Event):void {
			removeEventListener(Event.RENDER, configUI);
			
			exportImageCheck.visible = false;
			
			loopCheck.label = Locale.get("EJS_UI_LABEL_LOOP");
			loopCheck.addEventListener(Event.CHANGE, onPanelChanged, false, 0, true);
			
			exportImageCheck.label = Locale.get("EJS_UI_LABEL_EXPORT_AS_IMAGE");
			exportImageCheck.addEventListener(Event.CHANGE, onPanelChanged, false, 0, true);
			
			header.title = Locale.get("EJS_UI_TITLE_TIMELINE_SETTINGS");
			
			FontManager.setupContainer(this);
			
			ThemeManager.addEventListener(Event.CHANGE, updateTheme);
			updateTheme();
		}
		
		public function get isLoopChecked():Boolean { return loopCheck.selected; }
		public function set isLoopChecked(value:Boolean):void { loopCheck.selected = value; }
		
		public function get isExportImageChecked():Boolean { return exportImageCheck.selected; }
		public function set isExportImageChecked(value:Boolean):void { exportImageCheck.selected = value; }
		
		override public function set width(value:Number):void {
			super.width = value;
			bg.width = value;
		}
		
		override public function updateTheme(event:Event=null):void {
			super.updateTheme(event);
			
			var bgColor:int = ThemeManager.getParam('themeAppBackgroundColor');
			
			var ctf:ColorTransform = bg.transform.colorTransform;
			ctf.color = bgColor;
			bg.transform.colorTransform = ctf;
		}
		
	}
}