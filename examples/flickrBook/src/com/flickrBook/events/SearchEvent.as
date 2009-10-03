package com.flickrBook.events
{
	import flash.events.Event;

	public class SearchEvent extends Event
	{
		/*-.........................................Constants..................................*/
		public static const PREPARE:String 			= "SearchEvent.PREPARE";
		public static const FIND_USER:String 		= "SearchEvent.FIND_USER";
		public static const SEARCH:String 			= "SearchEvent.SEARCH";
		public static const INTERESTINGNESS:String 	= "SearchEvent.INTERESTINGNESS";
		
		/*-.........................................Properties..................................*/
		public var tags:String;
		public var user:String;
		public var page:uint = 1;
		public var userID:String;
		
		/*-.........................................Constructor..................................*/	
		public function SearchEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}