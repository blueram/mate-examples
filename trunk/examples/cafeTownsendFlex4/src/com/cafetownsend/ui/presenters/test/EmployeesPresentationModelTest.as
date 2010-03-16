package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.constants.Navigation;
	import com.cafetownsend.ui.components.EmployeesListItemRenderer;
	import com.cafetownsend.ui.presenters.EmployeeDetailPresentationModel;
	import com.cafetownsend.ui.presenters.EmployeesPresentationModel;
	import com.cafetownsend.ui.views.Employees;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	
	public class EmployeesPresentationModelTest
	{	
		protected var pm: EmployeesPresentationModel;
		
		[Before]
		public function setUp():void
		{
			pm = new EmployeesPresentationModel( new EventDispatcher() );
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
		
			pm.addEventListener( EmployeesPresentationModel.VIEW_STATE_CHANGED, callback, false, 0, true );
			pm.navigationPath = Navigation.EMPLOYEE_LIST;
			
			
		}
		
		protected function viewStateChanged(event:Event, passThroughData:Object ):void 
		{
			assertEquals(	"custom event to trigger binding was fired ", 
				EmployeesPresentationModel.VIEW_STATE_CHANGED, 
				event.type 
			);
			
			assertEquals(	"navigationPath has to be splitted to get the second path value only", 
							pm.viewState, 
							"employeeList"  
			);
		}
		
		protected function handleEventNeverOccurred( passThroughData:Object ):void 
		{
			Assert.fail( 'Binding Never triggered');
		}
	}
}