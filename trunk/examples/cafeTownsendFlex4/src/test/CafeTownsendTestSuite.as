package test
{
	import com.cafetownsend.model.managers.AuthorizationManager;
	import com.cafetownsend.model.managers.test.AuthorizationManagerTest;
	import com.cafetownsend.model.managers.test.EmployeeManagerTest;
	import com.cafetownsend.model.managers.test.EmployeeParserTest;
	import com.cafetownsend.model.managers.test.NavigationManagerTest;
	import com.cafetownsend.model.vos.Employee;
	import com.cafetownsend.model.vos.test.EmployeeTest;
	import com.cafetownsend.ui.presenters.test.EmployeeDetailPresentationModelTest;
	import com.cafetownsend.ui.presenters.test.EmployeeListPresentationModelTest;
	import com.cafetownsend.ui.presenters.test.EmployeesPresentationModelTest;
	import com.cafetownsend.ui.presenters.test.LoginPresentationModelTest;
	import com.cafetownsend.ui.presenters.test.MainUIPresentationModelTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class CafeTownsendTestSuite
	{
		//
		// utils
		public var employeeParser:EmployeeParserTest;
		//
		// vo
		public var employee: EmployeeTest;	
		//
		// manager
		public var authorizationManagerTest: AuthorizationManagerTest;
		public var navigationManagerTest: NavigationManagerTest;
		public var employeeManagerTest: EmployeeManagerTest;
		//
		// presentation models
		public var employeesPresentationModelTest: EmployeesPresentationModelTest;
		public var loginPresentationModelTest: LoginPresentationModelTest;
		public var mainUIPresentationModelTest: MainUIPresentationModelTest;
		public var employeeDetailPresentationModelTest: EmployeeDetailPresentationModelTest;
		public var employeeListPresentationModelTest: EmployeeListPresentationModelTest
		
		
	}
}