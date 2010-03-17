package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.managers.EmployeeManager;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import mx.collections.IList;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertTrue;
	import org.flexunit.asserts.fail;
	import org.flexunit.async.Async;
	import org.hamcrest.collection.array;
	import org.hamcrest.object.sameInstance;
	import org.hamcrest.object.strictlyEqualTo;
	
	import test.EmployeeFactory;
	
	public class EmployeeManagerTest
	{		
		
		protected var employee: Employee;
		protected var employees: Array;
		protected var manager: EmployeeManager;
		
		[Before]
		public function setUp():void
		{
			manager = new EmployeeManager();
			manager.dispatcher = new EventDispatcher();
			//
			// create a employee list
			// and add it to manager
			employees = EmployeeFactory.createEmployeeList();
			manager.saveEmpoyeeList( employees );

		}
		
		[After]
		public function tearDown():void
		{
			manager = null;
			employees.length = 0;
			employees = null;
			employee = null;
		}
		
		
		
		
		[Test(order="1", description="Test of deleting an employee from employee list")]
		public function deleteEmployee():void
		{
			//
			// Use the first employee from list
			var employee: Employee = manager.employeeList.getItemAt( 0 ) as Employee;
			// 
			// An employee can be removed only, if an employee is selected
			manager.selectEmployee( employee );
			
			var noOfEmployees: int = manager.employeeList.length;
			
			manager.deleteEmployeeHandler();
			
			assertFalse( manager.employeeList.length == noOfEmployees );
			assertTrue( manager.employeeList.length == noOfEmployees - 1 );
			
		}

		[Test(order="2", description="Test of saving an employee to employee list")]
		public function saveEmployee():void
		{
			//
			// create an employee
			var employee: Employee = EmployeeFactory.createEmployee( 100 );
			
			var noOfEmployees: int = manager.employeeList.length;
			//
			// and add it to list
			manager.saveEmployee( employee ); 
			
			assertFalse( manager.employeeList.length == noOfEmployees );
			assertTrue( manager.employeeList.length == noOfEmployees + 1 );
			
			//
			// A copy of the employee has to be stored at last index within list,
			// so we test here the emp_id only
			var addedEmployee: Employee = manager.employeeList.getItemAt( manager.employeeList.length - 1 ) as Employee;
			assertEquals( "Last employee in list should match ", 
							employee.emp_id,
							addedEmployee.emp_id
							);
			
		}
		
		
		[Test( order="3", description="Change a selected employee")]
		public function changeEmployee():void
		{
			employee = EmployeeFactory.createEmployee( 100 );
			manager.selectEmployee( employee );
			
			assertThat(	"selected employee has to be the same instance as created before", 
				manager.employee, 
				sameInstance( employee ) 
			);
			
			
		}

		
		
		[Test( order="4", description="Save new employee list")]
		public function changeEmployeeList():void
		{
			
			employees = EmployeeFactory.createEmployeeList();
			manager.saveEmpoyeeList( employees );
			
			assertThat(	"selected employee list has to be the same array as created before", 
				manager.employeeList.source, 
				array( employees ) 
			);
			
			
		}

		
		
		
		//--------------------------------------------------------------------------
		//
		// test bindings
		//
		//--------------------------------------------------------------------------
		

		
		[Test( order="6", async, description="Trigger EMPLOYEE_CHANGED selecting another employee")]
		public function triggerEmployeeChanged():void
		{
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			manager.addEventListener( EmployeeManager.EMPLOYEE_CHANGED, callback, false, 0, true );
			
			employee = EmployeeFactory.createEmployee( 100 );
			manager.selectEmployee( employee );
			
			
		}
		
		[Test( order="5", async, description="Trigger EMPLOYEE_LIST_CHANGED saving a new employee list")]
		public function triggerEmployeeListChanged():void
		{
			var callback: Function = Async.asyncHandler( this, triggerBindingEventHandler, 100, null, bindingNeverOccurred );
			manager.addEventListener( EmployeeManager.EMPLOYEE_LIST_CHANGED, callback, false, 0, true );
			
			employees = EmployeeFactory.createEmployeeList();
			manager.saveEmpoyeeList( employees );
		
			
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