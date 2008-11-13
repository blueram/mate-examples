package flickrWidget.events
{
	import flash.events.Event;

	public class InitializeEvent extends Event
	{
		
		//........................................Constants..........................................
		public static const BY_USERNAME:String 			= "initializeByUsernameEvent";
		public static const BY_TAGS:String 				= "initializeByTagsEvent";
		public static const BY_USERNAME_AND_TAGS:String = "initializeByUsernameAndTagsEvent";
		
		
		//........................................Properties.........................................
		public var username:String = '';
		public var tags:String = '';
		
		
		//........................................Constructor.........................................
		public function InitializeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}