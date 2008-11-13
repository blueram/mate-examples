package helloworld.services
{
	import helloworld.vos.Message;
	
	public class MockHelloService
	{
		public function sayHello(name:String):Message
		{
			if(name.toLowerCase() == "microsoft")
			{
				throw new Error("Error: Blue screen");
			}
			var message:String;
			var messageID:uint = Math.random() *10/2;
			switch(messageID)
			{
				case 0: message = "Hello " + name; break;
				case 1: message = "How are you doing, " + name; break;
				case 2: message = "Nice to meet you, " + name; break;
				case 3: message = "Hi "+name+", have a nice day!"; break;
				case 4: message = "Hello "+name+", what's new?"; break;
			}
			
			var response:Message = new Message();
			response.text = message;
			return response;
		}
	}
}