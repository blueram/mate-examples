package flickrWidget.views
{
	import flash.events.*;
	
	import mx.controls.SWFLoader;
	
	[Event(name="switchComplete", type="flash.events.Event")]
	
	public class ImageSwitchMediator extends EventDispatcher 
	{
		
		//..........................Properties..................
		private var  topImage:SWFLoader;
		private var  bottomImage:SWFLoader;
		private var switching:Boolean = false;
		
		
		///..........................Methods..................
		
		// -----------------------------------------------
		public function set image1(value:SWFLoader):void 
		{
			assignImage(value);
		}
		
		// -----------------------------------------------
		public function set image2(value:SWFLoader):void 
		{
			assignImage(value);		
		}
		
		// -----------------------------------------------
		public function switchImage(source:String):void 
		{
			//get the new source, wait for complete and switch
			topImage.source = source;
			switching = true;
		}
		
		// -----------------------------------------------
		public function removeFinished():void 
		{
			topImage.visible = true;
			var temp:SWFLoader = topImage;
			topImage = bottomImage;
			bottomImage = temp;
			
			//dispatch the finish event
			dispatchEvent(new Event("switchComplete"));
			
		}
		
		// ---------------------------------------------------
		private function imageLoaded(event:Event):void 
		{
			if (switching) 
			{
				if (bottomImage.visible)
					bottomImage.visible = false;
				else
					removeFinished();				
			}
			switching = false;
		}
		
		// ---------------------------------------------------
		private function assignImage(value:SWFLoader):void 
		{
			//check to see if we already have top image
			if (!topImage) 
			{
				topImage = value;
			}
			else
				bottomImage = value;
				
			value.visible = false;
			value.addEventListener(Event.COMPLETE, imageLoaded);
		}
	}
}