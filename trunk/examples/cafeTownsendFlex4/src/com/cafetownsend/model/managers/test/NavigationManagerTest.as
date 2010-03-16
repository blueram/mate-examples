package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.constants.Navigation;
	import com.cafetownsend.model.managers.NavigationManager;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	
	public class NavigationManagerTest
	{		
		protected var manager:NavigationManager;

		[Before]
		public function setUp():void
		{
			manager = new NavigationManager();
		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
		}
		
		
		[Test( async, description="AsyncTest of updating navigationPath" )]
		public function updatePath():void
		{
			var callback: Function = Async.asyncHandler( this, pathChanged, 100, null, handleEventNeverOccurred );
			manager.addEventListener( NavigationManager.NAVIGATION_CHANGED, callback, false, 0, true );
			
			manager.updatePath( Navigation.EMPLOYEE_DETAIL );

		}

		[Test( async, description="AsyncTest of updating navigationPath after login" )]
		public function updateAfterLogin():void
		{
			var callback: Function = Async.asyncHandler( this, pathChangedAfterLogin, 100, null, handleEventNeverOccurred );
			manager.addEventListener( NavigationManager.NAVIGATION_CHANGED, callback, false, 0, true );
			
			manager.updateAfterLogin( true );

		}

		
		protected function pathChanged( event:Event, passThroughData:Object ):void 
		{
			assertEquals("custom event to trigger binding was fired ", event.type, NavigationManager.NAVIGATION_CHANGED );
			assertEquals("navigationPath is changed ", manager.navigationPath, Navigation.EMPLOYEE_DETAIL );
		}
		
		protected function pathChangedAfterLogin( event:Event, passThroughData:Object ):void 
		{
			assertEquals("custom event to trigger binding was fired ", event.type, NavigationManager.NAVIGATION_CHANGED );
			assertEquals( manager.navigationPath, Navigation.EMPLOYEE_LIST );
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			Assert.fail( NavigationManager.NAVIGATION_CHANGED + ' Never Occurred');
		}
	}
}