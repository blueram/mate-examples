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
	import org.flexunit.asserts.fail;
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
		

		[Test( description="Change view state if navigationPath is changed")]
		public function changeNavigationPath():void
		{

			pm.navigationPath = Navigation.EMPLOYEE_LIST;
			
			assertEquals(	"navigationPath has to be splitted to get the second path value only", 
							pm.viewState, 
							"employeeList"  
			);
			
		}


		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		
		[Test( async, description="Trigger VIEW_STATE_CHANGED if navigationPath is changed")]
		public function triggerViewStateChanged():void
		{
			Async.proceedOnEvent( this, pm, EmployeesPresentationModel.VIEW_STATE_CHANGED, 200, bindingNeverOccurred );
			
			pm.navigationPath = Navigation.EMPLOYEE_LIST;		
			
		}
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'Bindings are not triggered');
		}
	}
}