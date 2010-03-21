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
		
		

		
		[Test(description="Creating error messages if login failed")]
		public function errorMessagesOnLoginFailed():void 
		{
			pm.login('', '' );
			
			assertTrue("userNameErrorString is set", pm.userNameErrorString != '');
			assertTrue("passwordErrorString is set", pm.passwordErrorString != '');
			
		}

		
		[Test(description="Change view state if login failed")]
		public function viewStateChangedIfLoginFailed():void 
		{
	
			pm.loginStatus = Authorization.FAILED;
			
			assertTrue("viewState is changed to ERROR_STATE", 
				pm.viewState == LoginPresentationModel.ERROR_STATE );
			
		}
		
		//--------------------------------------------------------------------------
		//
		// Test Bindings
		//
		//--------------------------------------------------------------------------
		
		[Test( async, description="AsyncTest to check validation handling on login")]
		public function triggerViewStateChangedOnInvalidLogin():void 
		{
			Async.proceedOnEvent( this, pm, LoginPresentationModel.VALIDATION_CHANGED, 200, bindingNeverOccurred );
			
			pm.login('', '' );
		}
		
		
		[Test( async, description="AsyncTest to trigger view state changed")]
		public function triggerChangeViewStateIfLoginFailed():void 
		{
			Async.proceedOnEvent( this, pm, LoginPresentationModel.VIEW_STATE_CHANGED, 200, bindingNeverOccurred );
			
			pm.loginStatus = Authorization.FAILED;
		}
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'Bindings are not triggered');
		}
		
	}
}