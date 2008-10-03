package example.view.test {

	import mx.core.Container;

	import net.digitalprimates.fluint.tests.TestCase;
	
	import example.model.Document;
	import example.model.DocumentFactory;
	import example.model.DocumentType;
	
	import example.view.DocumentViewFactory;
	
	
	public class TestDocumentViewFactory extends TestCase {
		
		private var viewFactory : DocumentViewFactory;
		
		private var plainDocument : Document;
		private var richDocument  : Document;
		private var bogusDocument : Document;

		
		override protected function setUp( ) : void {
			var documentFactory : DocumentFactory = new DocumentFactory();
			
			viewFactory = new DocumentViewFactory();
			
			plainDocument = documentFactory.createDocument(DocumentType.PLAIN, null);
			richDocument  = documentFactory.createDocument(DocumentType.RICH,  null);
			bogusDocument = new Document(new DocumentType("bogus type"));
		}
		

		[Test(description="Tests that the factory can create plain document views")]
		public function createPlainDocumentView( ) : void {
			var view : Container = viewFactory.createDocumentView(plainDocument);
			
			assertNotNull(view);
		}
		
		[Test(description="Tests that the factory can create rich document views")]
		public function createRichDocumentView( ) : void {
			var view : Container = viewFactory.createDocumentView(richDocument);
			
			assertNotNull(view);
		}
		
		[Test(description="Tests that the factory handles non-existing types correctly")]
		public function createNonExistingType( ) : void {
			try {
				viewFactory.createDocumentView(bogusDocument);
				
				fail("Creating a document view from a bogus document should throw an error");
			} catch ( e : ArgumentError ) { }		
		}
		
		[Test(description="Tests that the factory handles the case when the document is null")]
		public function createFromNull( ) : void {
			try {
				viewFactory.createDocumentView(null);
				
				fail("Creating a document view from null should throw an error");
			} catch ( e : ArgumentError ) { }		
		}
						
	}

}