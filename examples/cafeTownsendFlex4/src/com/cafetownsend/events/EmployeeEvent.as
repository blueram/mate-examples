package com.cafetownsend.events
{
	import com.cafetownsend.model.vos.Employee;
	
	import flash.events.Event;

	public class EmployeeEvent extends Event
	{
		//.........................................Constants..........................................
		
		public static const ADD: String 		= "addEmployeeEvent";
		public static const SELECT: String 		= "selectEmployeeEvent";
		public static const DELETE: String 		= "deleteEmployeeEvent";
		public static const SAVE: String 		= "saveEmployeeEvent";
		public static const CANCEL_EDIT: String = "cancelEditEmployeeEvent";
		
		//.........................................Properties..........................................
		public var employee:Employee;
		
		
		//.........................................Constructor..........................................
		
		public function EmployeeEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}