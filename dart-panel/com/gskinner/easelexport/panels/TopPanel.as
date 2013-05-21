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
	
	import com.gskinner.easelexport.PanelEvent;
	
	import fl.controls.CheckBox;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;
	import flash.text.AntiAliasType;
	
	import flash.geom.Transform;
	import flash.geom.ColorTransform;
	//import fl.text.ruler.ITabPicker;
	import com.gskinner.controls.CS7Button;
	
	public class TopPanel extends Sprite {
		
		public var exportLabel:TextField;
		public var exportButton:CS7Button;
		public var previewCheck:CheckBox;
		public var helpButton:Sprite;
		public var versionText:TextField;
		public var bg:Sprite;
		public var hr:Sprite;
		public var helpIcon:Sprite;
		
		protected var helpOffset:Number;
		
		public function TopPanel() {
			helpOffset = bg.width-helpButton.x;
			addEventListener(Event.RENDER, configUI);
		}
		
		public function set enabled(value:Boolean):void {
			mouseChildren = mouseEnabled = value;
			alpha = (value)? 1 : 0.5;
		}
		
		protected function configUI(evt:Event=null):void {
			
			removeEventListener(Event.RENDER, configUI);
			
			versionText.alpha = 0.5;
			
			exportButton.addEventListener(MouseEvent.CLICK, onExportClicked, false, 0, true);
			exportLabel.text = Locale.get("EJS_UI_BUTTON_EXPORT");
			exportLabel.mouseEnabled = false;
			
			if (previewCheck != null) {
				previewCheck.label = Locale.get("EJS_UI_LABEL_PREVIEW");
				previewCheck.addEventListener(Event.CHANGE, onPreviewChanged, false, 0, true);
			}
			
			helpButton.addEventListener(MouseEvent.CLICK, onHelpClicked, false, 0, true);
			
			FontManager.setupContainer(this, {versionText:true});
			
			ThemeManager.addEventListener(Event.CHANGE, updateTheme);
			updateTheme();
		}
		
		public function get isPreviewChecked():Boolean { return previewCheck != null && previewCheck.selected; }
		public function set isPreviewChecked(value:Boolean):void { if (previewCheck != null) previewCheck.selected = value; }
		
		protected function onPreviewChanged(event:Event):void {
			dispatchEvent(new PanelEvent(PanelEvent.SETTING_CHANGED));
		}
		
		protected function onExportClicked(event:MouseEvent):void {
			dispatchEvent(new PanelEvent(PanelEvent.EXPORT_CLICKED));
		}
		
		protected function onHelpClicked(event:MouseEvent):void {
			dispatchEvent(new PanelEvent(PanelEvent.HELP_CLICKED));
		}
		
		override public function get height():Number {
			return bg.height;
		}
		
		override public function set width(value:Number):void {
			bg.width = hr.width = value;
			
			helpButton.x = value - helpOffset;
			helpIcon.x = (value - helpOffset) + helpIcon.width;
			versionText.x = helpButton.x - versionText.width - 10;
		}
		
		public function updateTheme(event:Event=null):void {
			var bgColor:int = ThemeManager.getParam('themeAppBackgroundColor');			
			var txtColor:uint  = ThemeManager.getParam('themeStaticTextNormalColor');
			
			var tf:TextFormat = versionText.getTextFormat();
			tf.color = txtColor
			versionText.setTextFormat(tf);
			
			tf = exportLabel.getTextFormat();
			tf.color = txtColor;
			exportLabel.setTextFormat(exportLabel.defaultTextFormat = tf);			
			
			var ctf:ColorTransform = bg.transform.colorTransform;
			ctf.color = bgColor;
			bg.transform.colorTransform = ctf;
			
			ctf = hr.transform.colorTransform;
			ctf.color = ThemeManager.getParam('themePanelHeaderBorder');
			hr.transform.colorTransform = ctf;
			
			var icoColor:uint = ThemeManager.getParam('themeGenericIconNormal');
			ctf = helpIcon.transform.colorTransform;
			ctf.color = icoColor;
			helpIcon.transform.colorTransform = ctf;
			
		}
	}
}
