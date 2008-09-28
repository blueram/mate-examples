/* Copyright 2008 Theo Hultberg/Iconara */

package example.event {

	import flash.events.Event;

	import example.model.Document;
	import example.model.DocumentData;

	
	/**
	 * Events of this type are used to request document-related actions such as opening, closing, 
	 * deleting, creating and updating.
	 * 
	 * All instances of this event bubble.
	 */
	public class DocumentEvent extends Event {
		
		public static const     UPDATE : String = "update";
		public static const CREATE_NEW : String = "createNew";
		public static const       OPEN : String = "open";
		public static const      CLOSE : String = "close";
		public static const     DELETE : String = "delete";
		public static const       SAVE : String = "save";
		public static const      SAVED : String = "saved";

		
		/**
		 * Events that modify a document (UPDATE) can pass document data as an instance of 
		 * DocumentData in this property.
		 */
		public var data : DocumentData;
		
		/**
		 * Events that refer to a specific document (UPDATE, OPEN, CLOSE, DELETE, SAVE and SAVED)
		 * use this property to pass that document.
		 */
		public var reference : Document;
		
		/**
		 * Events that create new documents (CREATE_NEW) use this property to specify
		 * which kind of document to create. Must be one of the constants on the DocumentType class.
		 */
		public var documentType : String;
		
		
		public function DocumentEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false ) {
			super(type, true, cancelable);
		}
		
	}
	
}