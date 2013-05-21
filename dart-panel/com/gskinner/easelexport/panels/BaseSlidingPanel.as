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
	import com.gskinner.easelexport.PanelHeader;
	import com.gskinner.motion.GTween;
	
	import fl.motion.easing.Quadratic;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	public class BaseSlidingPanel extends Sprite {
		
		public static var TWEEN_DURATION:Number = .2;
		
		protected var stretch:Vector.<DisplayObject>;
		protected var move:Vector.<DisplayObject>
		protected var metrics:Dictionary;
		
		public var header:PanelHeader;
		protected var contents:Sprite;
		
		protected var _isAnimating:Boolean;
		protected var _isOpen:Boolean;
		protected var noEmbedFlds:Object;
		
		protected var contentMask:Bitmap;
		protected var maskTween:GTween;
		private var enableCache:Boolean;

		private var contentHeight:int;
		
		public function BaseSlidingPanel(title:String = "", isOpen:Boolean = true){
			tabChildren = false;
			
			header.addEventListener(MouseEvent.CLICK, onHeaderClicked, false, 0, true);
			
			//[SB] Note: Some CS3 Components have initial height of >60px, screwing up the height of any container they're within.
			//Look for 'bg' property instead, use content height as last resort. 
			contentHeight = super.height;
			var bg:DisplayObject = getChildByName("bg");
			if (bg) { contentHeight = bg.height; } 
			
			//Set initial mask height and state
			contentMask = new Bitmap(new BitmapData(width, contentHeight, false, 0x0));
			addChild(contentMask);
			
			maskTween = new GTween(contentMask, TWEEN_DURATION, {}, {ease: Quadratic.easeIn, onComplete: onMaskTweenComplete});
			this.mask = contentMask;
			
			header.isOpen = _isOpen = isOpen;
			contentMask.height = (isOpen)? contentHeight : 4;
		}
		
		public function set enabled(value:Boolean):void {
			mouseEnabled =  mouseChildren = value;
			alpha = (value)? 1 : .5;
		}
		
		protected function onMaskTweenComplete(tween:GTween):void {
			_isAnimating = false;
		}
		
		public function get isAnimating():Boolean {
			return _isAnimating;
		}
		
		protected function onHeaderClicked(event:MouseEvent):void {
			open(!isOpen);
		}
		
		//Tween a mask to Show / Hide main content area
		public function get isOpen():Boolean { return _isOpen; }
		public function open(value:Boolean, animate:Boolean = true):void {
			_isOpen = value;
			header.isOpen = value;
			//Stock menu seems to easeIn on close
			maskTween.ease = (value)? Quadratic.easeOut : Quadratic.easeIn;
			if (animate) {
				maskTween.proxy.height = (value)? contentHeight : header.height+2;
				_isAnimating = true;
			} else {
				contentMask.height = (value)? contentHeight : header.height+2;
			}
			dispatchEvent(new PanelEvent(value? PanelEvent.OPENING : PanelEvent.CLOSING));
		}
		
		override public function set width(value:Number):void {
			contentMask.width = value;
			header.width = value+2;
			header.x = -1;
			var l:uint = (stretch)? stretch.length : 0;
			for (var i:uint=0; i<l; i++) {
				var o:DisplayObject = stretch[i];
				o.width = value-metrics[o];
			}
			l = (move)? move.length : 0;
			for (i=0; i<l; i++) {
				o = move[i];
				o.x = value-metrics[o];
			}
		}
		
		override public function get height():Number {
			return contentMask.height
		}
		
		public function updateTheme(event:Event=null):void {
			header.textColor = ThemeManager.getParam('themeStaticTextNormalColor');
		}
		
		protected function onPanelChanged(event:Event):void {
			dispatchEvent(new PanelEvent(PanelEvent.SETTING_CHANGED));
		}
		
		protected function calculateMetrics():void {
			//Get metrics, used for sizing later.
			metrics = new Dictionary();
			var l:uint = (stretch)? stretch.length : 0;
			var w:Number = 280;
			for (var i:uint=0; i<l; i++) {
				var o:DisplayObject = stretch[i];
				metrics[o] = w-o.width;
			}
			l = (move)? move.length : 0;
			for (i=0; i<l; i++) {
				o = move[i];
				metrics[o] = w-o.x;
			}
		}
	}
}