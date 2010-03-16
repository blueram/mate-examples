package test
{
	import com.cafetownsend.model.vos.Employee;
	
	/**
	 * 
	 * Factory to create mock data for using in unit tests only
	 * 
	 **/
	public class EmployeeFactory
	{
		/**
		 * Helper method (factory) to create an Employee object
		 * 
		 */
		public static function createEmployee(id: int = 1):Employee 
		{
			var employee: Employee = new Employee( id );			
			return employee;			
		}
		
		/**
		 * Helper method (factory) to create a list of Employee object
		 * 
		 */
		public static function createEmployeeList(max: int = 10):Array 
		{
			var i:int = 0;
			var employee: Employee;
			var employees: Array = [];
			
			for ( i; i < max; i++ ) 
			{
				employee = createEmployee( i + 1 );
				employees.push( employee );				
			}
			
			return employees;			
		}
	}
}