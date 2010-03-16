package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.constants.Authorization;
	import com.cafetownsend.model.managers.AuthorizationManager;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	
	public class AuthorizationManagerTest
	{		
		protected var manager: AuthorizationManager;
		
		[Before]
		public function setUp():void
		{
			manager = new AuthorizationManager();
		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
		}
		
		
		[Test( async, description="AsyncTest of changing state after login")]
		public function changeStateOnLogin():void
		{
			var callback: Function = Async.asyncHandler( this, authorizationStateChangedAfterLogin, 100, null, handleEventNeverOccurred );
			manager.addEventListener( AuthorizationManager.STATUS_CHANGED, callback );

			manager.login('Flex', 'Mate');
			
			manager.removeEventListener( AuthorizationManager.STATUS_CHANGED, callback );
			
		}
		
		[Test( async, description="AsyncTest of changing states after logout")]
		public function changeStateOnLogout():void
		{
			var callback: Function = Async.asyncHandler( this, authorizationStateChangedAfterLogout, 100, null, handleEventNeverOccurred );
			manager.addEventListener( 	AuthorizationManager.STATUS_CHANGED, callback);

			manager.logout();

			manager.removeEventListener( AuthorizationManager.STATUS_CHANGED, callback);
		}
		
		protected function authorizationStateChangedAfterLogin( event:Event, passThroughData:Object ):void 
		{
			assertEquals("custom event to trigger binding was fired ", event.type, AuthorizationManager.STATUS_CHANGED );
			assertEquals( manager.status, Authorization.LOGGED_IN );
		}

		protected function authorizationStateChangedAfterLogout( event:Event, passThroughData:Object ):void 
		{
			assertEquals("custom event to trigger binding was fired ", event.type, AuthorizationManager.STATUS_CHANGED );
			assertEquals( manager.status, Authorization.LOGGED_OUT );
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			Assert.fail( AuthorizationManager.STATUS_CHANGED + ' Never Occurred');
		}
		
	}
}