/* Copyright 2008 Theo Hultberg/Iconara */

package example.model {

	/**
	 * This class is a glorified enumeration. It should not be instantiated, only
	 * used through its two constants PLAIN and RICH or through the static method
	 * fromString (and that should only be used when really needed).
	 * 
	 * It could very well be said that it's overkill with this much code just to implement
	 * an enum, and much simpler 
	 */
	public final class DocumentType {
		
		public static var PLAIN : DocumentType = new DocumentType("plain");
		public static var  RICH : DocumentType = new DocumentType("rich");
		
		
		private var _type : String;
		
		
		public function get type( ) : String {
			return _type;
		}
		
		
		public static function fromString( typeString : String ) : DocumentType {
			var instance : DocumentType = DocumentType[typeString.toUpperCase()];
			
			if ( instance == null ) {
				throw new ArgumentError("String does not match an existing document type: " + typeString);
			}
			
			return instance;
		}
		
		/**
		 * DO NOT INSTANTIATE.
		 * 
		 * Use constants or fromString, this constructor is private.
		 */
		public function DocumentType( type : String ) {
			_type = type;
		}
		
		public function toString( ) : String {
			return "[object DocumentType(\"" + type + "\")]";
		}

	}

}