package com.cafetownsend.model.constants
{
	final public class Navigation
	{
		public static const LOGIN:String 			= "login";
		public static const LOGGED_IN:String 		= "loggedIn";
		
		public static const EMPLOYEE_LIST:String 	= LOGGED_IN + "/employeeList";
		public static const EMPLOYEE_DETAIL:String 	= LOGGED_IN + "/employeeDetail";
	}
}