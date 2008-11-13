package flickrWidget.business
{		
	import flickrWidget.events.InitializeEvent;
	import flash.events.IEventDispatcher;
	import mx.core.Application;
	
	public class Initializer 
	{
		//.........................................Properties..........................
		private var dispatcher:IEventDispatcher = null;
		
		
		//.........................................Constructor.........................
		public function Initializer(dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
		
		//.........................................Methods............................
		public function initByFlashVars():void 
		{
			var username:String = Application.application.parameters.user;
			var tags:String = Application.application.parameters.tags;
			
			//check what we got
			//we can have only username, only tags or both
			var hasUsername:Boolean = username && username.length > 0;
			var hasTags:Boolean = tags && tags.length > 0;
			
			var event:InitializeEvent;
			
			if (hasUsername) 
			{
				//this event may also include tags
				event = new InitializeEvent(InitializeEvent.BY_USERNAME);
				event.username = username;
				event.tags = tags;
				
				dispatcher.dispatchEvent(event);
			}
			else if (hasTags)
			{
				event = new InitializeEvent(InitializeEvent.BY_TAGS);
				event.tags = tags;
				
				dispatcher.dispatchEvent(event);
			}
		}
	}
}