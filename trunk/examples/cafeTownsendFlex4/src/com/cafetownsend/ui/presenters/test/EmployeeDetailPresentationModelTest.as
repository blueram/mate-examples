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
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			pm.addEventListener( EmployeeDetailPresentationModel.TEMP_EMPLOYEE_CHANGED, callback, false, 0, true );
			
			// create an employee
			var employee: Employee = EmployeeFactory.createEmployee( 200 ); 
			// trigger TEMP_EMPLOYEE_CHANGED
			pm.selectedEmployee = employee;
			
		}

		[Test( async, description="Trigger VALIDATION_CHANGED trying to save an invalid employee")]
		public function triggerValidationChanged():void 
		{
			//
			// listener for VALIDATION_CHANGED event
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			pm.addEventListener( EmployeeDetailPresentationModel.VALIDATION_CHANGED, callback, false, 0, true );
			
			//
			// create an empty (invalid) employee
			pm.selectedEmployee = EmployeeFactory.createInvalidEmployee();
			//
			// and trigger VALIDATION_CHANGED
			pm.saveEmployee();

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