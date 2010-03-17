package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.vos.Employee;
	import com.cafetownsend.ui.presenters.EmployeeListPresentationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import test.EmployeeFactory;

	public class EmployeeListPresentationModelTest
	{		
		protected var pm:EmployeeListPresentationModel;
		
		[Before]
		public function setUp():void
		{
			pm = new EmployeeListPresentationModel( new EventDispatcher() );
		}
		
		[After]
		public function tearDown():void
		{
			pm = null;
		}
		

		[Test(description="Index of selected employee")]
		public function selectedEmployeeIndex():void 
		{
			var index: int = 5;
			// create employee list
			pm.employees = new ArrayCollection( EmployeeFactory.createEmployeeList( 20 ) );
			//
			// grab employee from list at index = 5
			var selectedEmployee: Employee = pm.employees.getItemAt( index ) as Employee;
			// set it as selected employee
			pm.selectedEmployee = selectedEmployee;
			// check selectedEmployeeIndex
			assertEquals( index, pm.selectedEmployeeIndex );
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		[Test(async,description="Trigger selectedEmployeeChanged")]
		public function triggerSelectedEmployeeChanged():void 
		{
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			pm.addEventListener( EmployeeListPresentationModel.SELECTED_EMPLOYEE_CHANGED, callback, false, 0, true );
			
			// trigger SELECTED_EMPLOYEE_CHANGED
			pm.selectedEmployee = EmployeeFactory.createEmployee();
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
			fail('Bindings are not triggered');
		}
		
	}
}