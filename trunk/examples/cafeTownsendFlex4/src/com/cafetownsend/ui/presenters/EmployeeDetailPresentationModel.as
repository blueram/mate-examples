package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.EmployeeEvent;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import spark.components.Application;
	
	public class EmployeeDetailPresentationModel extends EventDispatcher
	{
		
		// -------------------------------------------------------
		// Setters and getters
		// -------------------------------------------------------
		
		// selectedEmployee ...................................................
		
		private var _selectedEmployee:Employee = null;
		
		public function get selectedEmployee( ):Employee
		{
			return _selectedEmployee;
		}

		public function set selectedEmployee( employee:Employee ):void
		{
			if( employee != null )
			{
				_selectedEmployee = employee;
				
				if( employee != null )
					tempEmployee = _selectedEmployee.clone();

			}
		}
		
		private var _tempEmployee:Employee = new Employee();
		
		[Bindable(Event="tempEmployeeChange")]	
		public function get tempEmployee( ):Employee
		{
			return _tempEmployee;
		}
		
		public function set tempEmployee( employee:Employee ):void
		{
			if( _tempEmployee !== employee )
			{
				_tempEmployee = employee;
				
				this.dispatchEvent( new Event('tempEmployeeChange') );
				
			}
		}


		[Bindable(Event="tempEmployeeChange")]	
		public function get selectedEmployeeCanBeDeleted( ):Boolean
		{
			return !selectedEmployee.isEmpty();
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
		

		
		// -------------------------------------------------------
		// Constructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher
		public function EmployeeDetailPresentationModel( dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
		}
		
		
		// -------------------------------------------------------
		// Public methods
		// -------------------------------------------------------
		
		// cancelEmployeeEdits ...................................................
		public function cancelEmployeeEdits() : void 
		{
			clearValidationMessages();
			
			var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.CANCEL_EDIT);
			event.employee = null;
			
			dispatcher.dispatchEvent(event);
		}
		
		
		// saveEmployee ...................................................
		public function saveEmployee( ):void
		{
			if( isValid( tempEmployee ) )
			{
				clearValidationMessages();
				
				var event:EmployeeEvent = new EmployeeEvent( EmployeeEvent.SAVE );
				event.employee = _tempEmployee.clone();
				
				dispatcher.dispatchEvent(event);				
			}
			else
			{
				this.dispatchEvent( new Event("validationChange") );
			}
			
		}
		
		// deleteEmployee ...................................................
		
		public function deleteEmployee() : void 
		{
			// broadcast the event
			var event:EmployeeEvent = new EmployeeEvent(EmployeeEvent.DELETE);
			dispatcher.dispatchEvent( event );	
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
		
		
		// -------------------------------------------------------
		// Private methods
		// -------------------------------------------------------
		
		//  isValid ...................................................
		private function isValid( employee:Employee ):Boolean
		{
			var validFirstname: Boolean = employee.firstname != null && employee.firstname != "";
			var validLastname: Boolean = employee.lastname != null && employee.lastname != "";
			var validEmail: Boolean = employee.email != null && employee.email != "";
			
			_firstnameErrorString = ( validFirstname ) ? "" : "First Name is a required field.";
			_lastNameErrorString  = ( validLastname ) ? "" : "Last Name is a required field.";
			_emailErrorString  	  = ( validEmail ) ? "" : "Email is a required field.";
			
			return ( validFirstname  &&  validLastname && validEmail );
		}
		
		protected function clearValidationMessages():void 
		{
			_firstnameErrorString
			= _lastNameErrorString
				= _emailErrorString
				= '';
			
			dispatchEvent( new Event( "validationChange" ) );
		}
	}
}