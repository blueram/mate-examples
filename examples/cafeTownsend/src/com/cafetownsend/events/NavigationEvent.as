package com.cafetownsend.events
{
	import com.cafetownsend.model.vos.Employee;
	
	import flash.events.Event;

	public class NavigationEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const EMPLOYEE_LIST: String 	=	"employeeListNavigationEvent";
		public static const EMPLOYEE_DETAIL: String = "editEmployeeNavigationEvent"
		public static const LOGIN: String 			= "loginNavigationEvent";
		
		/*-.........................................Constructor..........................................*/	
		public function NavigationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}