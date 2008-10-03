/* Copyright 2008 Theo Hultberg/Iconara */

package example.model {
	
	import flash.utils.Dictionary;
	

	/**
	 * A factory for creating Document instances. The specific implementation created
	 * depends on the DocumentType that is passed to the createDocument method.
	 */
	public class DocumentFactory {
		
		use namespace app_internal;
		
		
		private static var _factoryMap : Dictionary;
		
		
		private function get factoryMap( ) : Dictionary {
			if ( _factoryMap == null ) {
				_factoryMap = new Dictionary();
				_factoryMap[DocumentType.PLAIN] = PlainDocument;
				_factoryMap[DocumentType.RICH]  = RichDocument;
			}
			
			return _factoryMap;
		}
		
		
		/**
		 * Create a new document of the specified type using some default data.
		 * 
		 * Throws an exception if this factory cannot create documents of the specified type.
		 */
		public function createDocument( type : DocumentType, data : DocumentData = null ) : Document {
			if ( factoryMap[type] == null ) {
				throw new ArgumentError("Cannot create document, unknown type: \"" + type + "\"");
			}
			
			var documentClass : Class = factoryMap[type];
		
			var document : Document = new documentClass();

			if ( data != null ) {
				document.setTitle(data.title);
				document.setText(data.text);
			}
		
			return document;
		}

	}

}