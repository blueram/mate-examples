/* Copyright 2008 Theo Hultberg/Iconara */

package example.model {

	/**
	 * This is a value object/data transfer object double for Document.
	 */
	public class DocumentData {
		
		public var title : String;
		public var text  : String;
		
		
		public function DocumentData( title : String = null, text : String = null ) {
			this.title = title;
			this.text  = text;
		}

	}

}