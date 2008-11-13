package flickrWidget.events
{
	import flash.events.Event;

	public class PhotoCollectionEvent extends Event
	{
		//.........................................Constants..........................................
		public static const SEARCH:String = "searchPhotoCollectionEvent";
		
		//.........................................Properties..........................................
		public var userId:String = '';
		public var tags:String = '';
		public var page:uint = 1;
		
		//.........................................Constructor..........................................
		public function PhotoCollectionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}