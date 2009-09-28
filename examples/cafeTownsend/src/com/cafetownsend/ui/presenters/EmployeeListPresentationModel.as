package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

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
		private var _selectedEmployeeIndex:int = -1;
		[Bindable(Event="employeeIndexChange")]
		public function get selectedEmployeeIndex():int
		{
			return _selectedEmployeeIndex;
		}
		
		// -------------------------------------------------------
		// Contructor
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
			clearSelectedEmployee();
		}
		
		// updateEmployee ...................................................
		public function updateEmployee( employee:Employee ) : void 
		{
			// boardcast an event that contains the selectedItem from the List
			var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.SELECT );
			event.employee = employee;
				
			dispatcher.dispatchEvent( event );
			// de-select the list item (it may not exist next time we're on this view)
			clearSelectedEmployee();
		}
		
		
		// logout ...................................................
		// send logout event
		public function logout() : void 
		{
			var event:LoginEvent = new LoginEvent(LoginEvent.LOGOUT);
			dispatcher.dispatchEvent(event);
		}
		
		// -------------------------------------------------------
		// Private methods
		// -------------------------------------------------------
		private function clearSelectedEmployee():void
		{
			dispatchEvent( new Event( "employeeIndexChange" ) );
		}
	}
}