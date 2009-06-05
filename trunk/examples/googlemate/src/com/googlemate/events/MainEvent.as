package com.googlemate.events
{
	import flash.events.Event;

	/**
	 *  Main Event
	 */
	public class MainEvent extends Event
	{
		// ----------------------------------------------------------------------------
		// 							Static constants
		// ----------------------------------------------------------------------------
		
		public static const DISABLE_SCREEN:String 	= "disableScreen";
		public static const ENABLE_SCREEN:String 	= "enableScreen";
		
		// ----------------------------------------------------------------------------
		// 							Contructor
		// ----------------------------------------------------------------------------
		
		public function MainEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}