package example.model.test {
	
	import flash.events.Event;

	import net.digitalprimates.fluint.tests.TestCase;
	
	import example.model.Document;
	import example.model.DocumentFactory;
	import example.model.DocumentData;
	import example.model.DocumentType;
	
	
	public class TestDocumentFactory extends TestCase {
		
		private var factory : DocumentFactory;
		
		
		override protected function setUp( ) : void {
			factory = new DocumentFactory();
		}
		
		
		[Test(description="Tests that the factory can create plain documents")]
		public function createPlainDocument( ) : void {
			var data : DocumentData = new DocumentData("Hello", "World");
			
			var document : Document = factory.createDocument(DocumentType.PLAIN, data);
			
			assertNotNull(document);
			
			// notice that I don't test that the document is an instance of a particular class that
			// wouldn't be appropriate since the job of the factory is to hide that kind of information,
			// and consequently testing it would couple the factory to a specific implementation
		}
		
		[Test(description="Tests that the factory can create rich documents")]
		public function createRichDocument( ) : void {
			var data : DocumentData = new DocumentData("Hello", "World");
			
			var document : Document = factory.createDocument(DocumentType.RICH, data);
			
			assertNotNull(document);
		}
		
		[Test(description="Tests that the factory handles non-existing types correctly")]
		public function createNonExistingType( ) : void {
			var data : DocumentData = new DocumentData("Hello", "World");
			
			try {
				factory.createDocument(null, data);
				
				fail("Creating a document with type null should throw an error");
			} catch ( e : ArgumentError ) {
				// notice that I catch ArgumentError here, had I written Error instead
				// I would mask the failure, since the assert/fail mechanism uses error
				// to signal failures
			}
			
			try {
				// here I cheat and use the fact that it's possible to instantiate a DocumentType
				// even though the class wasn't designed for that, it's not a big deal
				factory.createDocument(new DocumentType("this is a fake type"), data);
				
				fail("Creating a document with a bogus type should throw an error");
			} catch ( e : ArgumentError ) { }
		}
		
		[Test(description="Tests that the factory handles the case where the data is null correctly")]
		public function createWithoutData( ) : void {
			// just make sure this doesn't throw an error
			factory.createDocument(DocumentType.PLAIN, null);
		}
				
	}

}