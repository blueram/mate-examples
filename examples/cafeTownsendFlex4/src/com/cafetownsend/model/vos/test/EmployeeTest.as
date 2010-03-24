package com.cafetownsend.model.vos.test
{
	import com.cafetownsend.model.vos.Employee;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
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
			
			Assert.assertEquals("emp_id ", employee.emp_id, employeeCopied.emp_id );
			Assert.assertEquals("email ", employee.email, employeeCopied.email );
			Assert.assertEquals("firstname ", employee.firstname, employeeCopied.firstname );
			Assert.assertEquals("lastname ", employee.lastname, employeeCopied.lastname );
			Assert.assertEquals("startdate ", employee.startdate.toDateString(), employeeCopied.startdate.toDateString() );
		}


		[Test]
		public function cloneEmployee():void 
		{
			var employee: Employee = createEmployee();
			var employeeCloned: Employee = employee.clone();
			
			Assert.assertEquals("emp_id ", employee.emp_id, employeeCloned.emp_id );
			Assert.assertEquals("email ", employee.email, employeeCloned.email );
			Assert.assertEquals("firstname ", employee.firstname, employeeCloned.firstname );
			Assert.assertEquals("lastname ", employee.lastname, employeeCloned.lastname );
			Assert.assertEquals("startdate ", employee.startdate.toDateString(), employeeCloned.startdate.toDateString() );
		}

		[Test]
		public function employeeIsEmpty():void 
		{
			var employee: Employee = createEmployee();
			
			Assert.assertFalse( employee.isEmpty() );
			
			employee.email = '';
			employee.lastname = '';
			employee.firstname = '';
			
			Assert.assertTrue( employee.isEmpty() );
		}
		

		
		
	}
}