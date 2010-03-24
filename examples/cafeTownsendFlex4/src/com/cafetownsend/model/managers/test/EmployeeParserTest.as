package com.cafetownsend.model.managers.test
{
	import com.cafetownsend.model.managers.EmployeeParser;
	import com.cafetownsend.model.vos.Employee;
	
	import flash.utils.ByteArray;
	
	import flexunit.framework.Assert;
	
	import mx.collections.ArrayCollection;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertTrue;
	
	public class EmployeeParserTest
	{		
		
		
		[Embed( source="/assets/data/Employees.xml", mimeType="application/octet-stream" )] 
		protected var employeesXMLBytes: Class;
		protected var employeesXML: XML;
		
		
		[Before]
		public function setUp():void
		{
			var bytes: ByteArray = new employeesXMLBytes() as ByteArray;
			employeesXML = new XML( bytes.readUTFBytes( bytes.length ) );
		}
		
		[After]
		public function tearDown():void
		{
			employeesXML = null;
		}
		

		
		[Test(description="Test of parsing xml data and creating employees")]
		public function parseAndCreateEmployees():void
		{
			
			
			var employee:Employee;
			var parser: EmployeeParser = new EmployeeParser();
			
			var employees:Array = parser.loadEmployeesFromXML( employeesXML );
			
			Assert.assertNotNull( "employees ", employees );
			Assert.assertTrue("employees.length ", employees.length == 4 );
			
			employee = employees[ 0 ] as Employee;
			
			Assert.assertNotNull( employee );
			Assert.assertEquals( 1, employee.emp_id );
			Assert.assertEquals( "firstname ", "Sue", employee.firstname );
			Assert.assertEquals( "lastname ", "Hove", employee.lastname );
			Assert.assertEquals( "email ", "shove@cafetownsend.com", employee.email );
			Assert.assertEquals( "email ", "shove@cafetownsend.com", employee.email );
			Assert.assertNotNull( "startdate ", employee.startdate );

			employee = employees[ 1 ] as Employee;
			
			Assert.assertNotNull( employee );
			Assert.assertEquals( 2, employee.emp_id );
			Assert.assertEquals( "Matt", employee.firstname );
			Assert.assertEquals( "Boles", employee.lastname );
			Assert.assertEquals( "mboles@cafetownsend.com", employee.email );
			Assert.assertNotNull( "startdate ", employee.startdate );

		}
	}
}