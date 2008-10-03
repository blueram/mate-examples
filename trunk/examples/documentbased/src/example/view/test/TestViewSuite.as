package example.view.test {

	import net.digitalprimates.fluint.tests.TestSuite;
	
	
	public class TestViewSuite extends TestSuite {

		public function TestViewSuite( ) {
			addTestCase(new TestDocumentModel());
			addTestCase(new TestMainModel());
			addTestCase(new TestDocumentViewFactory());
		}
		
	}
	
}