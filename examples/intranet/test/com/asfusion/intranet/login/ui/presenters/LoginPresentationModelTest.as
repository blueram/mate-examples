package com.asfusion.intranet.login.ui.presenters
{
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import flexunit.framework.TestCase;

	public class LoginPresentationModelTest extends TestCase
	{
		private var model:LoginPresentationModel;
		private var dispatcher:IEventDispatcher;
		
		public function LoginPresentationModelTest(methodName:String=null)
		{
			super(methodName);
		}
		// This method will be called before every test function
		override public function setUp():void
		{
			super.setUp();
			
			dispatcher = new EventDispatcher();
			model = new LoginPresentationModel( dispatcher );
		}
		
		// This method will be called after every test function
		override public function tearDown():void
		{
			super.tearDown();
			model = null;
		}
		
		public function testLogin():void
		{
			// This is just a super simple test as an example.
			// In a real world scenario, there would be more tests that would test all the different possible cases.
			model.login( "","" );
			assertEquals( model.errorMessage, "Username and Password are required fields.");
			
		}
	}
}