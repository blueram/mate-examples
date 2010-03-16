package com.cafetownsend.model.managers
{
	import com.cafetownsend.events.NavigationEvent;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	
	public class EmployeeManager extends EventDispatcher 
	{
		//.........................................Properties..........................................
		
		private var _employeeList:ArrayCollection;
		
		//.........................................Setters and Getters..........................................

		public static const EMPLOYEE_LIST_CHANGED:String = "employeeListChanged";
		
		[Bindable (event="employeeListChanged")]
		public function get employeeList():ArrayCollection
		{
			return _employeeList;
		}
		
		private var _employee:Employee;
		public static const EMPLOYEE_CHANGED:String = "employeeChanged";
		
		[Bindable (event="employeeChanged")]
		public function get employee():Employee
		{
			return _employee;
		}
		
		//.........................................Methods..........................................
		
		// -----------------------------------------------------------
		public function saveEmpoyeeList(employees:Array):void 
		{
			_employeeList = new ArrayCollection(employees);
			dispatchEvent(new Event( EMPLOYEE_LIST_CHANGED ));
		}
		
		// -----------------------------------------------------------
		public function selectEmployee(employee:Employee):void 
		{
			_employee = employee;
			dispatchEvent(new Event( EMPLOYEE_CHANGED ));
		}
		
		// -----------------------------------------------------------
		
		
		public function deleteEmployee( ) : void 
		{
			Alert.show(	'Are you sure you want to delete this employee?',
				null,
				Alert.OK | Alert.CANCEL,
				FlexGlobals.topLevelApplication as Sprite,
				checkForDeleteEmployee,
				null,
				Alert.OK );
		}
		
		
		protected function checkForDeleteEmployee ( event: CloseEvent ):void 
		{
			// was the Alert event an OK
			if ( event.detail == Alert.OK ) 
				deleteEmployeeHandler();
		}

		
		public function deleteEmployeeHandler():void
		{
			var i:int = 0;
			var max: int = _employeeList.length;
			var storedEmployee: Employee;
			
			for (i; i < max; i++) 
			{
				storedEmployee = _employeeList.getItemAt( i ) as Employee;
			
				if( storedEmployee.emp_id == employee.emp_id )
				{
					// remove employee from list
					employeeList.removeItemAt( i );	
					break;
				}
			}
			
			// clear out the selected employee just in case
			selectEmployee( null );
			
			//
			// change view state back to employee list
			_dispatcher.dispatchEvent( new NavigationEvent( NavigationEvent.EMPLOYEE_LIST ) );
		}


		// -----------------------------------------------------------
		// -----------------------------------------------------------
		public function saveEmployee (employee:Employee) : void 
		{
			
			// assume the edited fields are not an existing employee, but a new employee
			// and set the ArrayCollection index to -1, which means this employee is not in our existing
			// employee list anywhere
			var dpIndex : int = -1;
			
			// loop thru the employee list
			for ( var i : uint = 0; i < employeeList.length; i++ ) 
			{
				// if the emp_id of the incoming employee matches an employee already in the list
				if ( employeeList[i].emp_id == employee.emp_id ) {
					// set our ArrayCollection index to that employee position
					dpIndex = i;
				}
			}
			
			// if it was an existing employee already in the ArrayCollection
			if ( dpIndex >= 0 ) {
				// update that employee's values
				( employeeList.getItemAt(dpIndex) as Employee ).copyFrom(employee);
			}
				// otherwise, if it didn't match any existing employees
			else 
			{
				// add the temp employee to the ArrayCollection
				employeeList.addItem( employee.clone() );
			}
			
			// clear out the selected employee
			selectEmployee(null);
			
		}
		
		/**
		 * The EmployerManager uses an injected dispatcher to dispatch events to the local controller
		 */
		private var _dispatcher : IEventDispatcher;

		public function set dispatcher( value : IEventDispatcher ) : void {
			_dispatcher = value;
		}

		
		
	}
}