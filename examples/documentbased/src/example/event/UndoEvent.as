/* Copyright 2008 Theo Hultberg/Iconara */

package example.event {
	
	import flash.events.Event;

	import example.manager.command.Undoable;
	
	
	/**
	 * Events of this type are used to request undo-related actions.
	 */
	public class UndoEvent extends Event {
		
		public static const         UNDO : String = "undo";
		public static const         REDO : String = "redo";
		public static const      RESTORE : String = "restore";
		public static const ADD_UNDOABLE : String = "addUndoable";
		
		
		/**
		 * Events that refer to a specific undoable (RESTORE, ADD_UNDOABLE) use 
		 * this property to pass that object.
		 */
		public var undoable : Undoable;
		
		
		public function UndoEvent( type : String, undoable : Undoable = null ) {
			super(type, true);
			
			this.undoable = undoable;
		}
		
	}
	
}