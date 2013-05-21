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