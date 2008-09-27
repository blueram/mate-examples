package example.view {

	import flash.utils.Dictionary;
	
	import mx.core.Container;
	
	import example.model.Document;
	import example.model.DocumentType;
	

	public class DocumentViewFactory {
		
		private static var _factoryMap : Dictionary;
		
		
		private function get factoryMap( ) : Dictionary {
			if ( _factoryMap == null ) {
				_factoryMap = new Dictionary();
				_factoryMap[DocumentType.PLAIN] = PlainDocumentView;
				_factoryMap[DocumentType.RICH]  = RichDocumentView;
			}
			
			return _factoryMap;
		}
		
		
		public function createDocumentView( document : Document ) : Container {
			var viewClass : Class = factoryMap[document.type];
			
			var view : Container = new viewClass();
			
			view.data = document;
			
			return view;
		}

	}

}