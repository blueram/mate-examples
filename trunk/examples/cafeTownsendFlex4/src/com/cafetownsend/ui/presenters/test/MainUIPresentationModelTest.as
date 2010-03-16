package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.constants.Navigation;
	import com.cafetownsend.ui.presenters.MainUIPresentationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	public class MainUIPresentationModelTest
	{		
		protected var pm: MainUIPresentationModel;
		
		[Before]
		public function setUp():void
		{
			pm = new MainUIPresentationModel( new EventDispatcher() );
		}
		
		[After]
		public function tearDown():void
		{
			pm = null;
		}
		
		
		[Test( async, description="AsyncTest of changing view state")]
		public function changeNavigationPath():void
		{
			var callback: Function = Async.asyncHandler( this, viewStateChanged, 100, null, handleEventNeverOccurred );
			
			pm.addEventListener( MainUIPresentationModel.VIEW_STATE_CHANGED, callback, false, 0, true );
			pm.navigationPath = Navigation.LOGGED_IN;
			
			
		}
		
		protected function viewStateChanged(event:Event, passThroughData:Object ):void 
		{
			assertEquals("custom event to trigger binding was fired ", 
				MainUIPresentationModel.VIEW_STATE_CHANGED, 
						event.type 
					);
			
			assertEquals(	"navigationPath has to be splitted to get the first path value only", 
				pm.viewState, 
				Navigation.LOGGED_IN  
			);
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'View state never changed');
		}
		
	}
}