package example.model {
	
	import flash.utils.Dictionary;
	

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
		
		
		public function createDocument( title : String, text : String, type : String ) : Document {
			var documentClass : Class = factoryMap[type];
			
			var document : Document = new documentClass(type);
			
			document.setTitle(title);
			document.setText(text);
			
			return document;
		}

	}

}