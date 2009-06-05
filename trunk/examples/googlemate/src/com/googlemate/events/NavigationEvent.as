package com.googlemate.events
{
	import flash.events.Event;

	/**
	 *  Navigation Event
	 */
	public class NavigationEvent extends Event
	{
		// ----------------------------------------------------------------------------
		// 							Static constants
		// ----------------------------------------------------------------------------
		
		public static const NAVIGATE_TO_VIEW:String 	= "navigateToView";
		public static const SHOW_CONTENT_VIEW:String 	= "showContentView";
		public static const HIDE_CONTENT_VIEW:String 	= "hodeContentView";
		
		// ----------------------------------------------------------------------------
		// 							Public properties
		// ----------------------------------------------------------------------------
		
		public var parent:String;
		public var view:int;
		public var label:String;
		public var location:String;
		
		// ----------------------------------------------------------------------------
		// 							Contructor
		// ----------------------------------------------------------------------------
		
		public function NavigationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, 
										parent:String="", 
										view:int=-1, 
										label:String="",
										location:String="")
		{
			super(type, bubbles, cancelable);
			
			this.parent = parent;
			this.view = view;
			this.label = label;
			this.location = location;
		}
		
	}
}