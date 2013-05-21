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
	
	import com.gskinner.easelexport.DashedUnderline;
	import com.gskinner.easelexport.PanelEvent;
	
	import fl.controls.CheckBox;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.utils.Dictionary;
	import fl.controls.Button;
	import flash.display.SimpleButton;
	import flash.geom.ColorTransform;
	import flash.text.TextFormat;
	import com.gskinner.controls.CS7Button;

	public class SettingsPanel extends BaseSlidingPanel	{
		
		public var outputLabel:TextField;
		public var outputText:TextField;
		public var outputBtn:CS7Button;
		public var outputIcon:MovieClip;
		
		public var editBtn:CS7Button;
		public var editLabel:TextField;
		
		public var bg:Sprite;
		
		public function SettingsPanel() {
			super();
			
			addEventListener(Event.RENDER, configUI);		
			
		}
		
		protected function configUI(evt:Event=null):void {
			removeEventListener(Event.RENDER, configUI);
			
			outputLabel.text = Locale.get("EJS_UI_LABEL_OUTPUT");
			outputBtn.addEventListener(MouseEvent.CLICK, onOutputClicked, false, 0, true);
			outputIcon.mouseEnabled = false;
			
			editLabel.mouseEnabled = false;
			editLabel.text = Locale.get("EJS_UI_LABEL_EDIT_SETTINGS");
			editBtn.addEventListener(MouseEvent.CLICK, onEditClicked, false, 0, true);
			
			header.title = Locale.get("EJS_UI_TITLE_EXPORT_SETTINGS");
			
			//Configure layout
			stretch = new <DisplayObject>[
				bg,
				contentMask,
				outputText,
			];
			
			move = new <DisplayObject>[
				outputBtn,
				outputIcon,
				editBtn,
				editLabel
			];
			calculateMetrics();
			
			FontManager.setupContainer(this, {outputText:1, imagesText:1, soundsText:1, libsText:1});
			
			
			ThemeManager.addEventListener(Event.CHANGE, updateTheme);
			updateTheme();
		}
		
		protected function onOutputClicked(event:Event):void {
			dispatchEvent(new PanelEvent(PanelEvent.OUTPUT_CLICKED));
		}
		
		protected function onEditClicked(evt:MouseEvent):void {
			dispatchEvent(new PanelEvent(PanelEvent.EDIT_CLICKED));
		}
		
		public function set displayOutputPath(value:String):void {
			outputText.text = value; 
			outputText.scrollH = 0;
			outputText.scrollH = outputText.maxScrollH;
		}
		
		override public function set width(value:Number):void {
			if (value == super.width) { return; }
			super.width = value;
			outputText.scrollH = outputText.maxScrollH;
		}
		
		override public function updateTheme(event:Event=null):void {
			super.updateTheme(event);			
			
			var txtColor:uint = ThemeManager.getParam('themeStaticTextNormalColor') 
			
			var tf:TextFormat = outputLabel.getTextFormat();
			tf.color = txtColor;
			outputLabel.setTextFormat(outputLabel.defaultTextFormat=tf);
			
			tf = outputText.getTextFormat();
			tf.color = txtColor;
			outputText.setTextFormat(outputText.defaultTextFormat=tf);
			
			
			tf = editLabel.getTextFormat();
			tf.color = txtColor;
			editLabel.setTextFormat(editLabel.defaultTextFormat=tf);
			
			var bgColor:int = ThemeManager.getParam('themeAppBackgroundColor');
						
			var ctf:ColorTransform = bg.transform.colorTransform;
			ctf.color = bgColor;
			bg.transform.colorTransform = ctf;
			
			ctf = outputIcon.transform.colorTransform;
			ctf.color = ThemeManager.getParam('themeGenericIconNormal');
			outputIcon.transform.colorTransform = ctf;
			
		}
		
		
		
	}
}