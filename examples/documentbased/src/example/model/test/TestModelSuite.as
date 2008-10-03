package example.model.test {
	
	import net.digitalprimates.fluint.tests.TestSuite;
	
	
	public class TestModelSuite extends TestSuite {

		public function TestModelSuite( ) {
			addTestCase(new TestDocument());
			addTestCase(new TestDocumentFactory());
		}
		
	}
	
}