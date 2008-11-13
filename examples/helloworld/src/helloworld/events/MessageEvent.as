package helloworld.events
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		//.........................................Constants..........................................
		public static const GET:String = "getMessageEvent";

		//...........................................Properties........................................
		public var name:String;
		
		//..........................................Contructor.........................................
		public function MessageEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}	
	}
	
}