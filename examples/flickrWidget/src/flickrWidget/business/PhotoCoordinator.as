package flickrWidget.business
{
	import flickrWidget.events.PhotoEvent;
	import flickrWidget.vos.Photo;
	
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	public class PhotoCoordinator
	{
		
		//..........................Properties..................
		private var photos:ArrayCollection;
		private var currentIndex:uint = 0;
		private var dispatcher:IEventDispatcher = null;
		private var timer:Timer = null;
		
		public var interval:uint = 5000;
		
		
		//..........................Constructor..................
		public function PhotoCoordinator(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
		
		
		//..........................Methods..................
		
		// ----------------------------------------------------------
		public function setUp(photos:ArrayCollection):void 
		{
			this.photos = photos;	
		}
		
		// ----------------------------------------------------------
		public function start():void 
		{
			//only start if we got at least one photo
			if (this.photos && this.photos.length > 0) 
			{
				//set up a random number to start with
				var randomNum:Number = Math.floor(Math.random() * this.photos.length);
				currentIndex = randomNum;
				dispatchNext();
			}
		}
		
		// ----------------------------------------------------------
		public function navigateNext():void 
		{
			//start timer
			timer = new Timer(interval, 1);
   	        timer.start();
      	    timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerEnd);
		}
		
		// ----------------------------------------------------------
		private function timerEnd(event:TimerEvent):void 
		{
			//when timer finishes, trigger switch event
			dispatchNext();
		}
		
		// ----------------------------------------------------------
		private function dispatchNext():void 
		{
			var photoEvent:PhotoEvent = new PhotoEvent(PhotoEvent.SELECT);
			photoEvent.photo = photos.getItemAt(currentIndex) as Photo;			
			dispatcher.dispatchEvent(photoEvent);
			
			if (currentIndex + 1 == photos.length)
				currentIndex = 0;
			else
				currentIndex++;
		}
	}
}