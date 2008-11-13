package flickrWidget.events
{
	import flash.events.Event;
	import flickrWidget.vos.Photo;
	
	public class PhotoEvent extends Event
	{
		//........................................Constants..........................................
		public static const SELECT:String 			= "selectPhotoEvent";
		public static const SELECT_APPLIED:String 	= "selectAppliedPhotoEvent";		
		
		//.........................................Properties..........................................
		public var photo:Photo = null;	
		
		//.........................................Constructor.........................................
		public function PhotoEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}	
		
	}
}