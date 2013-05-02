package com.gskinner.easelexport
{
	import flash.events.Event;
	
	public class PanelEvent extends Event
	{
		public static var OPENING:String = "open";
		public static var CLOSING:String = "close";
		
		public static var SETTING_CHANGED:String = "PanelChanged";
		
		public static var OUTPUT_CLICKED:String = "OutputButtonClicked";
		public static var HELP_CLICKED:String = "HelpButtonClicked";
		public static var EXPORT_CLICKED:String = "exportClicked";
		
		public static var EDIT_CLICKED:String = "editClicked";
		
		
		public function PanelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new PanelEvent(type, bubbles, cancelable);
		}
	}
	
}