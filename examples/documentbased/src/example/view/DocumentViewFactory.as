/* Copyright 2008 Theo Hultberg/Iconara */

package example.view {

	import flash.utils.Dictionary;
	
	import mx.core.Container;
	
	import example.model.Document;
	import example.model.DocumentType;
	

	/**
	 * A factory for document views that can create the appropriate view instance for a particular
	 * document type.
	 */
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
		
		
		/**
		 * Creates a view that can display the specified document. 
		 * 
		 * Throws an exception if the document is null or if the document type is not supported.
		 */
		public function createDocumentView( document : Document ) : Container {
			if ( document == null ) {
				throw new ArgumentError("Cannot create document view, document was null");
			}
			
			if ( factoryMap[document.type] == null ) {
				throw new ArgumentError("Cannot create new document view, unknown type: \"" + document.type + "\"");
			}
			
			var viewClass : Class = factoryMap[document.type];
			
			var view : Container = new viewClass();
			
			view.data = document;
			
			return view;
		}

	}

}