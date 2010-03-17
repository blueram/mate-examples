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
		
		


		[Test(description="Changing view state if navigationPath is changed")]
		public function changeNavigationPath():void
		{

			pm.navigationPath = Navigation.LOGGED_IN;
			
			assertEquals(	"navigationPath has to be splitted to get the first path value only", 
				pm.viewState, 
				Navigation.LOGGED_IN  
			);
			
		}

		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		[Test(async, description="Trigger VIEW_STATE_CHANGED changing navigationPath")]
		public function triggerViewStateChanged():void
		{
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			
			pm.addEventListener( MainUIPresentationModel.VIEW_STATE_CHANGED, callback, false, 0, true );
			pm.navigationPath = Navigation.LOGGED_IN;		
			
		}
		
		
		public function triggerBindingEventHandler( event:Event, passThroughData:Object ):void 
		{
			//
			// Nothing to do here! 
			// Because is the binding not triggered,
			// a fail message is shown in bindingNeverOccurred();
		}
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'Bindings are not triggered');
		}
		
	}
}