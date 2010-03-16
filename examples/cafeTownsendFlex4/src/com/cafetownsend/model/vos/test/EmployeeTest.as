package com.cafetownsend.model.vos.test
{
	import com.cafetownsend.model.vos.Employee;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.hamcrest.object.sameInstance;

	public class EmployeeTest
	{	

		
		protected function createEmployee():Employee 
		{
			var employee: Employee = new Employee();
			employee.email = "shove@cafetownsend.com";
			employee.firstname = "Sue";
			employee.lastname = "Hove";
			employee.startdate = new Date();
			
			return employee;
			
		}
		
		[Test]
		public function copyEmployee():void 
		{
			var employee: Employee = createEmployee();
			var employeeCopied: Employee = new Employee()
			employeeCopied.copyFrom( employee );
			
			assertEquals("emp_id ", employee.emp_id, employeeCopied.emp_id );
			assertEquals("email ", employee.email, employeeCopied.email );
			assertEquals("firstname ", employee.firstname, employeeCopied.firstname );
			assertEquals("lastname ", employee.lastname, employeeCopied.lastname );
			assertEquals("startdate ", employee.startdate.toDateString(), employeeCopied.startdate.toDateString() );
		}


		[Test]
		public function cloneEmployee():void 
		{
			var employee: Employee = createEmployee();
			var employeeCloned: Employee = employee.clone();
			
			assertEquals("emp_id ", employee.emp_id, employeeCloned.emp_id );
			assertEquals("email ", employee.email, employeeCloned.email );
			assertEquals("firstname ", employee.firstname, employeeCloned.firstname );
			assertEquals("lastname ", employee.lastname, employeeCloned.lastname );
			assertEquals("startdate ", employee.startdate.toDateString(), employeeCloned.startdate.toDateString() );
		}
		

		
		
	}
}