package example.view.test {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	import net.digitalprimates.fluint.tests.TestCase;

	import example.event.DocumentEvent;
	
	import example.model.Document;
	import example.model.DocumentFactory;
	import example.model.DocumentType;
	import example.model.DocumentData;
	
	import example.view.model.MainModel;
	
	
	public class TestMainModel extends TestCase {
		
		private var dispatcher : IEventDispatcher;
		
		private var model : MainModel;
		
		private var documents     : ArrayCollection;
		private var openDocuments : ArrayCollection;
		
		private var openDocument : Document;
		private var closedDocument : Document;

		
		override protected function setUp( ) : void {
			var documentFactory : DocumentFactory = new DocumentFactory();
			
			var document1 : Document = documentFactory.createDocument(DocumentType.PLAIN, new DocumentData("One",   "Two"));
			var document2 : Document = documentFactory.createDocument(DocumentType.PLAIN, new DocumentData("Three", "Four"));
			var document3 : Document = documentFactory.createDocument(DocumentType.RICH,  new DocumentData("Five",  "Six"));
			
			dispatcher = new EventDispatcher();
			
			model = new MainModel();
			model.dispatcher = dispatcher;
			
			documents     = new ArrayCollection([document1, document2, document3]);
			openDocuments = new ArrayCollection([document2, document3]);
			
			closedDocument = document1;
			openDocument   = document2;
		}
		
		
		[Test]
		public function openSelectorEnabled( ) : void {
			assertFalse("The open selector should be disabled before the documents property is set", model.openSelectorEnabled);
			
			model.documents = new ArrayCollection();
			
			assertFalse("The open selector should be disabled when there are no documents", model.openSelectorEnabled);
			
			model.documents	= documents;

			assertTrue("The open selector should be enabled when there is more than one document", model.openSelectorEnabled);
			
			model.documents = null;
			
			assertFalse("The open selector should be disabled when the documents property has been null'ed", model.openSelectorEnabled);
		}
		
		[Test]
		public function closeButtonEnabled( ) : void {
			assertFalse("The close button should be disabled before the currentDocument property is set", model.closeButtonEnabled);
			
			model.currentDocument = openDocument;
			
			assertTrue("The close button should be enabled when the currentDocument property is set", model.closeButtonEnabled);
			
			model.currentDocument = null;

			assertFalse("The close button should be disabled when the documents property has been null'ed", model.closeButtonEnabled);
		}
		
		[Test]
		public function deleteButtonEnabled( ) : void {
			assertFalse("The delete button should be disabled before the currentDocument property is set", model.deleteButtonEnabled);
			
			model.currentDocument = openDocument;
			
			assertTrue("The delete button should be enabled when the currentDocument property is set", model.deleteButtonEnabled);
			
			model.currentDocument = null;

			assertFalse("The delete button should be disabled when the documents property has been null'ed", model.deleteButtonEnabled);
		}
		
		[Test]
		public function isOpen( ) : void {
			assertFalse("No document should be reported as open before the openDocuments property is set", model.isOpen(openDocument));
			assertFalse("Null should never be open", model.isOpen(null));
			
			model.openDocuments = openDocuments;
			
			assertTrue("An open document should be reported as open", model.isOpen(openDocument));
			assertFalse("A closed document should not be reported as open", model.isOpen(closedDocument));
		}
		
		[Test(description="Tests that DocumentEvent.OPEN is dispatched by openDocument")]
		public function openDispatched( ) : void {
			var document : Document = openDocument;
			
			dispatcher.addEventListener(DocumentEvent.OPEN, asyncHandler(onOpen, 100, document));
			
			model.openDocument(document);
		}
		
		private function onOpen( event : DocumentEvent, data : Object ) : void {
			assertEquals(data, event.reference);
		}
		
		[Test(description="Tests that DocumentEvent.CREATE_NEW is dispatched by newPlainDocument, with the right document type set")]
		public function createNewPlainDispatched( ) : void {
			dispatcher.addEventListener(DocumentEvent.CREATE_NEW, asyncHandler(onNewPlain, 100, DocumentType.PLAIN));
			
			model.newPlainDocument();
		}
		
		private function onNewPlain( event : DocumentEvent, data : Object ) : void {
			assertEquals(data, event.documentType);
		}
		
		[Test(description="Tests that DocumentEvent.CREATE_NEW is dispatched by newRichDocument, with the right document type set")]
		public function createNewRichDispatched( ) : void {
			dispatcher.addEventListener(DocumentEvent.CREATE_NEW, asyncHandler(onNewRich, 100, DocumentType.RICH));
			
			model.newRichDocument();
		}
		
		private function onNewRich( event : DocumentEvent, data : Object ) : void {
			assertEquals(data, event.documentType);
		}
		
		[Test(description="Tests that DocumentEvent.DELETE is dispatched by deleteDocument")]
		public function deleteDispatched( ) : void {
			var document : Document = openDocument;
			
			dispatcher.addEventListener(DocumentEvent.DELETE, asyncHandler(onDelete, 100, document));
			
			model.currentDocument = document;
			model.deleteCurrentDocument();
		}
		
		private function onDelete( event : DocumentEvent, data : Object ) : void {
			assertEquals(data, event.reference);
		}
		
		[Test(description="Tests that DocumentEvent.CLOSE is dispatched by closeDocument")]
		public function closeDispatched( ) : void {
			var document : Document = openDocument;
			
			dispatcher.addEventListener(DocumentEvent.CLOSE, asyncHandler(onClose, 100, document));
			
			model.currentDocument = document;
			model.closeCurrentDocument();
		}
		
		private function onClose( event : DocumentEvent, data : Object ) : void {
			assertEquals(data, event.reference);
		}
		
		[Test(description="Tests that the right binding events are dispatched when properties are set")]
		public function bindings( ) : void {
			var eventHandler1 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler2 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler3 : Function = asyncHandler(onBindingEvent, 100);
			
			model.addEventListener("currentDocumentChanged", eventHandler1);
			model.currentDocument = openDocument;
			model.removeEventListener("currentDocumentChanged", eventHandler1);
			
			model.addEventListener("documentsChanged", eventHandler2);
			model.documents = documents;
			model.removeEventListener("documentsChanged", eventHandler2);
			
			model.addEventListener("documentsChanged", eventHandler3);
			// changing the documents collection should fire binding events on the model
			documents.removeItemAt(0);
			model.removeEventListener("documentsChanged", eventHandler3);
		}
		
		private function onBindingEvent( event : Event, data : Object ) : void {
			// there are no tests here because the only thing that is important is that
			// the event is dispatched (if it isn't the testing framework will report an error)
		}
		
	}

}