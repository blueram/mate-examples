package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.constants.Authorization;
	import com.cafetownsend.ui.presenters.LoginPresentationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;

	public class LoginPresentationModelTest
	{		
		protected var pm: LoginPresentationModel;
		
		[Before]
		public function setUp():void
		{
			pm = new LoginPresentationModel( new EventDispatcher() );
		}
		
		[After]
		public function tearDown():void
		{
			pm = null;
		}
		

		[Test( async, description="AsyncTest to check validation handling on login")]
		public function loginFailed():void 
		{
			var callback: Function = Async.asyncHandler( this, loginFailedHandler, 100, null, handleEventNeverOccurred );
			pm.addEventListener( LoginPresentationModel.VALIDATION_CHANGED, callback, false, 0, true );
			
			pm.login('', '' );
		}
		
		public function loginFailedHandler(event:Event, passThroughData:Object ):void 
		{
			assertEquals(	"custom event to trigger bindings was fired ", 
							LoginPresentationModel.VALIDATION_CHANGED, 
							event.type 
						);
			
			assertTrue("userNameErrorString is set", 
						pm.userNameErrorString != '');

			assertTrue("passwordErrorString is set", 
						pm.passwordErrorString != '');
			
		}

		[Test( async, description="AsyncTest to check validation handling on login")]
		public function login():void 
		{
			var callback: Function = Async.asyncHandler( this, loginHandler, 100, null, handleEventNeverOccurred );
			pm.addEventListener( LoginPresentationModel.VALIDATION_CHANGED, callback, false, 0, true );
			
			pm.login('username', 'passwort' );
		}
		
		public function loginHandler(event:Event, passThroughData:Object ):void 
		{
			assertEquals(	"custom event to trigger bindings was fired ", 
							LoginPresentationModel.VALIDATION_CHANGED, 
							event.type 
						);
			
			assertTrue("userNameErrorString is not set", 
						pm.userNameErrorString == '');

			assertTrue("passwordErrorString is not set", 
						pm.passwordErrorString == '');
			
		}

		[Test( async, description="AsyncTest of changing view state depending on login status")]
		public function changeLoginStatus():void 
		{
			var callback: Function = Async.asyncHandler( this, loginStatusChangedHandler, 100, null, handleEventNeverOccurred );
			pm.addEventListener( LoginPresentationModel.VIEW_STATE_CHANGED, callback, false, 0, true );
			
			pm.loginStatus = Authorization.FAILED;
		}
		
		public function loginStatusChangedHandler(event:Event, passThroughData:Object ):void 
		{
			assertEquals(	"custom event to trigger bindings was fired ", 
							LoginPresentationModel.VIEW_STATE_CHANGED, 
							event.type 
						);
			
			assertTrue("userNameErrorString is not set", 
						pm.viewState == LoginPresentationModel.ERROR_STATE );
			
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'Binding never triggered');
		}
		
	}
}