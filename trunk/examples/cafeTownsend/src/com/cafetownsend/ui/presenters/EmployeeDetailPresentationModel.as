package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class EmployeeDetailPresentationModel extends EventDispatcher
	{ 
		private var tempEmployee:Employee;
		private var _selectedEmployee:Employee = null;
		
		[Bindable(Event="employeeChange")]
		public function set selectedEmployee( employee:Employee ):void
		{
			_selectedEmployee = employee;
			if( employee )
			{
				tempEmployee = new Employee();
				tempEmployee.copyFrom( employee );
			}
			dispatchEvent( new Event("employeeChange") );
		}
		public function get selectedEmployee( ):Employee
		{
			return _selectedEmployee;
		}
		
		//  firstnameErrorString ...................................................
		private var _firstnameErrorString:String = "";
		
		[Bindable(Event="validationChange")]
		public function get firstnameErrorString():String
		{
			return _firstnameErrorString
		}
		
		//  lastNameErrorString ...................................................
		private var _lastNameErrorString:String = "";
		
		[Bindable(Event="validationChange")]
		public function get lastNameErrorString():String
		{
			return _lastNameErrorString;
		}
		
		//  emailErrorString ...................................................
		private var _emailErrorString:String = "";
		
		[Bindable(Event="validationChange")]
		public function get emailErrorString():String
		{
			return _emailErrorString;
		}
		
		
		private var dispatcher:IEventDispatcher
		public function EmployeeDetailPresentationModel( dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
		
		public function cancelEmployeeEdits() : void 
		{
			var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.CANCEL_EDIT);
			event.employee = selectedEmployee;
				
			dispatcher.dispatchEvent(event);
		}
		
		public function deleteEmployee( ) : void 
		{
			// broadcast the event
			var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.DELETE);
			event.employee =  selectedEmployee;
			
			dispatcher.dispatchEvent(event);
		}
		
		private function isValid( employee:Employee ):Boolean
		{
			_firstnameErrorString = ( employee.firstname ) ? "" : "First Name is a required field.";
			_lastNameErrorString  = ( employee.lastname  ) ? "" : "Last Name is a required field.";
			_emailErrorString  	  = ( employee.email     ) ? "" : "Email is a required field.";
			dispatchEvent( new Event( "validationChange" ) );
			return ( employee.firstname  &&  employee.lastname && employee.email );
		}
		
		public function saveEmployee( ):void
		{
			if( isValid( tempEmployee ) )
			{
				// to make it here the fields must have been valid
				// broadcast the event
				var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.SAVE);
				event.employee = tempEmployee;
						
				dispatcher.dispatchEvent(event);
			}
		}
		
		public function updateFirstName( firstName:String ):void
		{
			tempEmployee.firstname = firstName;
		}
		
		public function updateLastName( lastName:String ):void
		{
			tempEmployee.lastname = lastName;
		}
		
		public function updateEmail( email:String ):void
		{
			tempEmployee.email = email;
		}
		
		public function updateStartDate( date:Date ):void
		{
			tempEmployee.startdate = date;
		}
	}
}