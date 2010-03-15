package com.cafetownsend.model.vos
{
	
	[Bindable]
	public class Employee 
	{
		/*-.........................................Properties..........................................*/
		public var emp_id : uint;
		public var firstname : String;
		public var lastname : String;
		public var email : String;
		public var startdate : Date;
		
		static public var currentIndex : uint = 1000;
		
		/*-.........................................Constructor..........................................*/
		public function Employee(	emp_id : uint =			0, 
									firstname : String =	"", 
									lastname : String =		"", 
									email : String =		"", 
									startdate : Date =		null ) 
		{
			this.emp_id = ( emp_id == 0 ) ?  currentIndex += 1 : emp_id;
			this.firstname = firstname;
			this.lastname = lastname;
			this.email = email;
			this.startdate =  ( startdate == null ) ?  new Date() : startdate;
		}
		
		/*-.........................................Methods..........................................*/
		
		public function copyFrom(newEmployee:Employee):void 
		{
			this.emp_id = newEmployee.emp_id;
			this.email = newEmployee.email;
			this.firstname = newEmployee.firstname;
			this.lastname = newEmployee.lastname;
			this.startdate = newEmployee.startdate;			
		}
		
		public function clone():Employee 
		{
			var employee: Employee = new Employee();
			
			employee.emp_id = this.emp_id;
			employee.email = this.email;
			employee.firstname = this.firstname;
			employee.lastname = this.lastname;
			employee.startdate = this.startdate;
			
			return employee;
			
		}
		
		public function isEmpty():Boolean
		{
			return this.firstname == '' && this.lastname == '' && this.email == '';
		}
	}
}