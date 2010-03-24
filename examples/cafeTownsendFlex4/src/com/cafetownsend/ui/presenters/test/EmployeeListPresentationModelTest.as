package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.vos.Employee;
	import com.cafetownsend.ui.presenters.EmployeeListPresentationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
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
			Assert.assertEquals( index, pm.selectedEmployeeIndex );
			
		}
		
		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		[Test(async,description="Trigger selectedEmployeeChanged")]
		public function triggerSelectedEmployeeChanged():void 
		{
			Async.proceedOnEvent( this, pm, EmployeeListPresentationModel.SELECTED_EMPLOYEE_CHANGED, 200, bindingNeverOccurred );
			
			// trigger SELECTED_EMPLOYEE_CHANGED
			pm.selectedEmployee = EmployeeFactory.createEmployee();
		}
		
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			Assert.fail('Bindings are not triggered');
		}
		
	}
}