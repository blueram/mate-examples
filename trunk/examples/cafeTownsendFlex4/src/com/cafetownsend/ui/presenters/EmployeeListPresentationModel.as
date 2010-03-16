package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.events.CloseEvent;
	
	
	public class EmployeeListPresentationModel extends EventDispatcher
	{
		
		// -------------------------------------------------------
		// Setters and getters
		// -------------------------------------------------------
		
		// employees ...................................................
		private var _employees:ArrayCollection = null;
		
		
		[Bindable(Event="employeesChange")]
		public function set employees( list:ArrayCollection ):void
		{
			_employees = list;
			dispatchEvent( new Event("employeesChange") );
		}
		public function get employees( ):ArrayCollection
		{
			return _employees;
		}
		
		// selectedEmployeeIndex ...................................................
		
		[Bindable(Event="selectedEmployeeChanged")]
		public function get selectedEmployeeIndex():int
		{
			if( selectedEmployee == null )
				return -1;
			
			var i:int = 0;
			var max: int = employees.length;
			var storedEmployee: Employee;
			var emp_id: int = selectedEmployee.emp_id;
			
			for (i; i < max; i++) 
			{
				storedEmployee = employees.getItemAt( i ) as Employee;
				
				if( storedEmployee.emp_id == emp_id )
					return i;
			}
			
			return -1;
		}
		
		
		
		[Bindable(Event="selectedEmployeeChanged")]
		public function get hasSelecetdEmployee():Boolean
		{
			return selectedEmployee != null;
		}
		
		
		
		// selectedEmployee ...................................................		
		
		private var _selectedEmployee:Employee = null;
		
		public static const SELECTED_EMPLOYEE_CHANGED:String = "selectedEmployeeChanged";
		
		[Bindable(event="selectedEmployeeChanged")]
		public function get selectedEmployee():Employee
		{
			return _selectedEmployee;
		}
		
		public function set selectedEmployee(value:Employee):void
		{
			if (_selectedEmployee != value) {
				_selectedEmployee = value;
				dispatchEvent(new Event(SELECTED_EMPLOYEE_CHANGED));
			}
		}		
		
		// -------------------------------------------------------
		// Constructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function EmployeeListPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		// -------------------------------------------------------
		// Public methods
		// -------------------------------------------------------
		public function addNewEmployee() : void 
		{
			var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.ADD );
			event.employee = new Employee();
			
			dispatcher.dispatchEvent( event );
			
		}
		
		// selectEmployee ...................................................
		public function selectEmployee( employee:Employee ) : void 
		{
			// boardcast an event that contains the selectedItem from the List
			var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.SELECT );
			event.employee = employee;
			
			dispatcher.dispatchEvent( event );
		}
		
		// editEmployee ...................................................
		public function editEmployee() : void 
		{
			// boardcast an event that contains the selectedItem from the List
			var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.EDIT );
			event.employee = selectedEmployee;
			
			dispatcher.dispatchEvent( event );
			
		}
		
		// deleteEmployee ...................................................
		
		public function deleteEmployee() : void 
		{
			// broadcast the event
			var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.DELETE);		
			dispatcher.dispatchEvent( event );
			
		}
		
		
		// logout ...................................................
		// send logout event
		public function logout() : void 
		{
			var event:LoginEvent = new LoginEvent(LoginEvent.LOGOUT);
			dispatcher.dispatchEvent(event);
		}
		
	}
}