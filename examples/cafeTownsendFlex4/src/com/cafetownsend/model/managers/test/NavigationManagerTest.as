package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.constants.Navigation;
	import com.cafetownsend.model.managers.NavigationManager;
	
	import flash.events.Event;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;
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
		
		
		[Test( description="Update navigationPath" )]
		public function updatePath():void
		{
			manager.updatePath( Navigation.EMPLOYEE_DETAIL );
			
			assertEquals("navigationPath is changed ", manager.navigationPath, Navigation.EMPLOYEE_DETAIL );
			
		}
		
		
		[Test( description="Update navigationPath after login" )]
		public function updateNavigatioinPathAfterLogin():void
		{
			manager.updateAfterLogin( true );
			
			assertEquals( manager.navigationPath, Navigation.EMPLOYEE_LIST );
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		
		[Test( async, description="Trigger NAVIGATION_CHANGED updating the path" )]
		public function triggerNaviationChanged():void
		{
			Async.proceedOnEvent( this, manager, NavigationManager.NAVIGATION_CHANGED, 200, bindingNeverOccurred );
			
			manager.updatePath( Navigation.EMPLOYEE_LIST );
			
		}
		
		
		
		[Test( async, description="Trigger NAVIGATION_CHANGED after login" )]
		public function triggerNavigationChangedAfterLogin():void
		{
			Async.proceedOnEvent( this, manager, NavigationManager.NAVIGATION_CHANGED, 200, bindingNeverOccurred );
			
			manager.updateAfterLogin( true );			
		}

		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			fail('Bindings are not triggered');
		}
	}
}