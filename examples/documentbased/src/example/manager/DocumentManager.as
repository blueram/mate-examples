/* Copyright 2008 Theo Hultberg/Iconara */

package example.manager {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import example.model.Document;
	import example.model.app_internal;

	import example.event.UndoEvent;
	
	import example.manager.command.Command;
	import example.manager.command.Undoable;
	import example.manager.command.UpdateDocumentCommand;
	
	
	/**
	 * The DocumentManager manages a single document. It provides a transactional interface
	 * for manipulating that document, making sure that actions are undoable, and keeping
	 * track of whether or not the document needs saving or not (i.e. if it's "dirty").
	 * 
	 * All modifications of the managed document are done in commands, and a change is
	 * undoable the particular command implements the Undoable interface. After an undoable
	 * command has been executed it is reported to the undo system.
	 * 
	 * Currently there is only one action that modifies the document: update, which has the
	 * corresponding command UpdateDocumentCommand.
	 */
	public class DocumentManager extends EventDispatcher {
		
		/*
		 * All methods on the Document class that are destructive (i.e. changes the object's state)
		 * are marked with the app_internal namespace. This means that any code that wants to modify
		 * a document needs to open that namespace somehow. This makes it easier to keep track on
		 * where destructive changes are made.
		 */
		use namespace app_internal;
		
		
		private var _document : Document;
		
		private var _documentDirty : Boolean;
		
		private var _dispatcher : IEventDispatcher;
		
	
		[Bindable(event="documentChanged")]	
		public function get document( ) : Document {
			return _document;
		}
		
		/**
		 * Returns whether or not the managed document has unsaved changes.
		 */
		[Bindable(event="documentDirtyChanged")]
		public function get documentDirty( ) : Boolean {
			return _documentDirty;
		}
	
		/**
		 * The DocumentManager needs a way to dispatch events to the local controller
		 * via an event dispatcher, this is where that dispatcher is injected.
		 */
		public function set dispatcher( value : IEventDispatcher ) : void {
			_dispatcher = value;
		}


		/** Internal method for dispatching the "documentChanged" event. */
		private function dispatchDocumentChanged( ) : void {
			dispatchEvent(new Event("documentChanged"));
		}
		
		/** Internal method for dispatching the "documentDirtyChanged" event. */
		private function dispatchDocumentDirtyChanged( ) : void {
			dispatchEvent(new Event("documentDirtyChanged"));
		}
		
		/** Listener for the Event.CHANGE event on the managed Document instance. */
		private function onDocumentChange( event : Event ) : void {
			_documentDirty = true;
			
			dispatchDocumentDirtyChanged();
		}
		
		/**
		 * Sets the document instance that this manager manages, this triggers the
		 * dispatch of both the "documentChanged" and "documentDirtyChanged" events.
		 */
		public function setDocument( d : Document ) : void {
			if ( _document != null ) {
				_document.removeEventListener(Event.CHANGE, onDocumentChange);
			}
			
			_document      = d;
			_documentDirty = false;
			
			if ( _document != null ) {
				_document.addEventListener(Event.CHANGE, onDocumentChange);
			}
			
			dispatchDocumentChanged();
			dispatchDocumentDirtyChanged();
		}
		
		/**
		 * After a document has been saved (an action that this manager is unaware of),
		 * this method needs to be called to unset the dirty flag.
		 */
		public function documentSaved( ) : void {
			_documentDirty = false;
			
			dispatchDocumentDirtyChanged();
		}
		
		/**
		 * Modifes the managed document by setting a new title and text. This action
		 * is undoable.
		 */
		public function update( title : String, text : String ) : void {
			exec(new UpdateDocumentCommand(_document, title, text));
		}
		
		/**
		 * Executes the specified command by calling its execute method. Also, and more
		 * importantly, it checks if that command is undoable. Undoable commands are
		 * reported to the undo system by dispatching the UndoEvent.ADD_UNDOABLE event.
		 */
		private function exec( command : Command ) : void {
			command.execute();
			
			if ( command is Undoable ) {
				_dispatcher.dispatchEvent(new UndoEvent(UndoEvent.ADD_UNDOABLE, Undoable(command)));
			}
		}

	}
	
}