package com.cafetownsend.ui.presenters.test
{
	import com.cafetownsend.model.vos.Employee;
	import com.cafetownsend.ui.presenters.EmployeeDetailPresentationModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	
	import test.EmployeeFactory;
	
	public class EmployeeDetailPresentationModelTest
	{		
		protected var pm:EmployeeDetailPresentationModel;
		
		[Before]
		public function setUp():void
		{
			pm = new EmployeeDetailPresentationModel( new EventDispatcher() );
		}
		
		[After]
		public function tearDown():void
		{
			pm = null;
		}
		
		
		[Test( description="Test to create a temp employee")]
		public function tempEmployeeIsCreated():void 
		{
			var employee: Employee = EmployeeFactory.createEmployee( 200 ); 
			pm.selectedEmployee = employee;			
			
			assertNotNull("tempEmployee is not null", pm.tempEmployee );
			assertTrue("tempEmployee !== selectedEmployee ", pm.tempEmployee !== pm.selectedEmployee );
			assertEquals("emp_id ", pm.selectedEmployee.emp_id, pm.tempEmployee.emp_id );
			assertEquals("emp_id ", 200, pm.tempEmployee.emp_id );
		}


		
		
		[Test( description="Show error strings trying to save an invalid employee")]
		public function showErrorStrings():void 
		{

			//
			// create an empty (invalid) employee
			pm.selectedEmployee = EmployeeFactory.createInvalidEmployee();
			//
			// and try to save it
			pm.saveEmployee();
			
			assertTrue("emailErrorString is not empty", pm.emailErrorString != '' );
			assertTrue("lastNameErrorString is not empty", pm.lastNameErrorString != '' );
			assertTrue("firstnameErrorString is not empty", pm.firstnameErrorString != '' );
		
			
		}
		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		
		
		[Test( async, description="Trigger TEMP_EMPLOYEE_CHANGED if a new employee is selected")]
		public function triggerTempEmployeeChanged():void 
		{
			Async.proceedOnEvent( this, pm, EmployeeDetailPresentationModel.TEMP_EMPLOYEE_CHANGED, 200, bindingNeverOccurred );
			
			// create an employee
			var employee: Employee = EmployeeFactory.createEmployee( 200 ); 
			// trigger TEMP_EMPLOYEE_CHANGED
			pm.selectedEmployee = employee;
			
		}

		[Test( async, description="Trigger VALIDATION_CHANGED trying to save an invalid employee")]
		public function triggerValidationChanged():void 
		{
			//
			// check if VALIDATION_CHANGED will be fired
			Async.proceedOnEvent( this, pm, EmployeeDetailPresentationModel.VALIDATION_CHANGED, 200, bindingNeverOccurred );
			
			//
			// create an empty (invalid) employee
			pm.selectedEmployee = EmployeeFactory.createInvalidEmployee();
			//
			// and trigger VALIDATION_CHANGED
			pm.saveEmployee();

		}
		
		protected function bindingNeverOccurred( passThroughData:Object ):void 
		{
			fail( 'Bindings are not triggered');
		}
		
		
	}
}