package example.model.test {
	
	import flash.events.Event;

	import net.digitalprimates.fluint.tests.TestCase;
	
	import example.model.app_internal;
	import example.model.Snapshot;
	import example.model.Document;
	import example.model.PlainDocument;
	
	
	public class TestDocument extends TestCase {
		
		use namespace app_internal;
		

		private var document : Document;

		
		override protected function setUp( ) : void {
			document = new PlainDocument();
			document.setTitle("Hello World");
			document.setText("Lorem ipusm dolor sit amet.");
		}
		

		[Test(description="Tests creation and loading of snapshots")]
		public function createAndLoadSnapshot( ) : void {
			var titleBefore : String = document.title;
			var textBefore  : String = document.text;
			
			var snapshot : Snapshot = document.createSnapshot();
			
			document.setTitle("Wohoo!");
			document.setText("Wheeee!");
			
			document.loadSnapshot(snapshot);
			
			assertEquals("Wrong title", titleBefore, document.title);
			assertEquals("Wrong text",  textBefore,  document.text);
		}
		
		[Test(description="Tests that the correct binding events are dispatched when modifying title and text")]
		public function bindingEvents( ) : void {
			var bindingHandler1 : Function = asyncHandler(onBindingEvent, 100);
			var bindingHandler2 : Function = asyncHandler(onBindingEvent, 100);
			
			document.addEventListener("change", bindingHandler1);
			document.setTitle("Hello");
            
			// remove the first event handler so that it doesn't get triggered by the next change
			document.removeEventListener("change", bindingHandler1);
			
			document.addEventListener("change", bindingHandler2);
			document.setText("Test");
		}
		
		private function onBindingEvent( event : Event, data : Object ) : void { }
				
	}

}