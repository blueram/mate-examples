package example.view.test {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;

	import net.digitalprimates.fluint.tests.TestCase;

	import example.event.UndoEvent;
	
	import example.model.Document;
	import example.model.DocumentFactory;
	import example.model.DocumentType;
	import example.model.DocumentData;
	import example.model.app_internal;
	
	import example.manager.command.Undoable;
	
	import example.view.model.DocumentModel;
	
	
	public class TestDocumentModel extends TestCase {
		
		use namespace app_internal;
		
		
		private var dispatcher : IEventDispatcher;
		
		private var model : DocumentModel;
		
		private var document : Document;
		
		private var undoables : Array;

		
		override protected function setUp( ) : void {
			dispatcher = new EventDispatcher();
			
			model = new DocumentModel();
			model.dispatcher = dispatcher;
			
			document = new DocumentFactory().createDocument(DocumentType.PLAIN, new DocumentData("Hello", "World"));
			
			undoables = [
				new MockUndoable(new Date()),
				new MockUndoable(new Date()),
				new MockUndoable(new Date()),
				new MockUndoable(new Date()),
				new MockUndoable(new Date()),
				new MockUndoable(new Date()),
				new MockUndoable(new Date())
			];
		}
		
		
		[Test(description="Checks that the undoHistory property behaves right, for example reverses the input")]
		public function undoHistory( ) : void {
			assertNotNull("The undoHistory property should never be null", model.undoHistory);
			assertEquals("The undoHistory should be empty by default", 0, model.undoHistory.length);
			
			model.undoHistory = undoables;
			
			var outputHistory : Array = model.undoHistory;
			
			assertNotNull("The undoHistory property should not be null after being set", outputHistory);
			assertEquals("The undoHistory length should equal the length of the input", undoables.length, outputHistory.length);
			
			assertEquals("The undoHistory property getter should reverse the input (1)", undoables[0], outputHistory[outputHistory.length - 1]);
			assertEquals("The undoHistory property getter should reverse the input (2)", undoables[1], outputHistory[outputHistory.length - 2]);
			assertEquals("The undoHistory property getter should reverse the input (3)", undoables[undoables.length - 1], outputHistory[0]);
			assertEquals("The undoHistory property getter should reverse the input (4)", undoables[undoables.length - 2], outputHistory[1]);
		}
		
		[Test(description="Tests that the display title has the right value depending on the situation")]
		public function displayTitle( ) : void {
			assertEquals("Initially the displayTitle property should be an empty string", "", model.displayTitle);
			
			model.title = "Hello";
			
			assertEquals("The displayTitle property should equal the title property", "Hello", model.displayTitle);
			
			model.documentDirty = true;
			
			assertEquals("When the documentDirty property is true the displayTitle property should be suffixed with a star", "Hello *", model.displayTitle);
		}
		
		[Test(description="Tests that the undo button is enabled in the right situations")]
		public function undoButtonEnabled( ) : void {
			assertFalse("The undo button should be disabled by default", model.undoButtonEnabled);
			
			model.undoPossible = true;
			
			assertTrue("The undo button should be enabled if undo is possible", model.undoButtonEnabled);
		}
		
		[Test(description="Tests that the redo button is enabled in the right situations")]
		public function redoButtonEnabled( ) : void {
			assertFalse("The redo button should be disabled by default", model.redoButtonEnabled);
			
			model.redoPossible = true;
			
			assertTrue("The redo button should be enabled if redo is possible", model.redoButtonEnabled);
		}
		
		[Test(description="Tests that the save button is enabled in the right situations")]
		public function saveButtonEnabled( ) : void {
			assertFalse("The save button should be disabled by default", model.saveButtonEnabled);
			
			model.documentDirty = true;
			
			assertTrue("The save button should be enabled if the documentDirty property is true", model.saveButtonEnabled);
		}
		
		[Test(description="Tests that the labelForUndoable method creates labels on the right format")]
		public function labelForUndoable( ) : void {
			var undoable : Undoable = undoables[0];
			
			// the labelForUndoable method depends on this property being set
			model.undoHistory = undoables;
			
			assertTrue("The label didn't match the specified pattern", /^\d+\. \w+ \(\d+:\d+:\d+\)$/.test(model.labelForUndoable(undoable)));
		}
		
		[Test(description="Tests that UndoEvent.UNDO is dispatched when undo is called")]
		public function undoDispatched( ) : void {
			dispatcher.addEventListener(UndoEvent.UNDO, asyncHandler(onUndo, 100));
			
			model.undo();
		}
		
		private function onUndo( event : UndoEvent, data : Object ) : void { }
		
		[Test(description="Tests that UndoEvent.REDO is dispatched when redo is called")]
		public function redoDispatched( ) : void {
			dispatcher.addEventListener(UndoEvent.REDO, asyncHandler(onRedo, 100));
			
			model.redo();
		}
		
		private function onRedo( event : UndoEvent, data : Object ) : void { }
		
		[Test(description="Tests that UndoEvent.RESTORE is dispatched when restore is called, and with the right undoable")]
		public function restoreDispatched( ) : void {
			var undoable : Undoable = undoables[0];
			
			dispatcher.addEventListener(UndoEvent.RESTORE, asyncHandler(onRestore, 100, undoable));
			
			model.restore(undoable);
		}
		
		private function onRestore( event : UndoEvent, data : Object ) : void {
			assertEquals(data, event.undoable);
		}
		
		[Test(description="Tests that the right binding events are dispatched when properties are set")]
		public function bindings( ) : void {
			var eventHandler1 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler2 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler3 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler4 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler5 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler6 : Function = asyncHandler(onBindingEvent, 100);
			var eventHandler7 : Function = asyncHandler(onBindingEvent, 100);
			
			model.addEventListener("undoStateChanged", eventHandler1);
			model.undoPossible = true;
			model.removeEventListener("undoStateChanged", eventHandler1);
			
			model.addEventListener("undoStateChanged", eventHandler2);
			model.redoPossible = true;
			model.removeEventListener("undoStateChanged", eventHandler2);
			
			model.addEventListener("documentDirtyChanged", eventHandler3);
			model.documentDirty = true;
			model.removeEventListener("documentDirtyChanged", eventHandler3);
			
			model.addEventListener("titleChanged", eventHandler4);
			model.addEventListener("textChanged", eventHandler5);
			// changing the document should fire both title and text binding events
			model.document = document;
			model.removeEventListener("titleChanged", eventHandler4);
			model.removeEventListener("textChanged", eventHandler5);
			
			model.addEventListener("titleChanged", eventHandler6);
			// changing the title of the document should fire binding events on the model
			document.setTitle("Hello World!");
			model.removeEventListener("titleChanged", eventHandler6);
			
			model.addEventListener("titleChanged", eventHandler7);
			// changing the text of the document should fire binding events on the model
			document.setText("Hello World!");
			model.removeEventListener("titleChanged", eventHandler7);
		}
		
		private function onBindingEvent( event : Event, data : Object ) : void {
			// there are no tests here because the only thing that is important is that
			// the event is dispatched (if it isn't the testing framework will report an error)
		}
		
	}

}


import example.manager.command.Undoable;


internal class MockUndoable implements Undoable {
	
	private var _ts : Date;
	
	
	public function get timestamp( ) : Date {
		return _ts;
	}
	
	public function get description( ) : String {
		return "MockUndoable";
	}


	public function MockUndoable( ts : Date ) {
		_ts = ts;
	}
	
	public function execute( ) : void { }

	public function undo( ) : void { }
	
	public function redo( ) : void { }
	
}