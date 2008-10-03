/* Copyright 2008 Theo Hultberg/Iconara */

package example.view.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.binding.utils.BindingUtils;
	
	import example.manager.command.Undoable;
	
	import example.event.DocumentEvent;
	import example.event.UndoEvent;
	
	import example.model.Document;
	import example.model.DocumentData;


	/**
	 * The presentation model of DocumentView.
	 * 
	 * The dispatcher, document, documentDirty, undoHistory, undoPossible and redoPossible
	 * properties are injected by the local controller.
	 * 
	 * The methods save, undo, redo, restore and update (which is private but called by
	 * the setters for title and text) insulates the view from the details of communicating
	 * with the application. In the current implementation they dispatch events on the 
	 * dispatcher provided by the local controller, but this could very well change and the
	 * important thing here is that the view doesn't need to know if it does.
	 * 
	 * The presentation model acts as a mediator between the view and the application. It
	 * presents a view-centric interface of the application model for the view, and takes
	 * care of all state logic like which buttons should be enabled, etc. This makes the
	 * view very simple, and it makes the state logic testable.
	 * 
	 * This particular presentation model is also unware of how the rest of the application
	 * works, it communicates with the local and application controllers with implicit
	 * invokation, i.e. it dispatches events. 
	 * 
	 * Many of the properties of this class only have a getter, but are still bindable.
	 * The way this works is that the getters are defined to use custom binding events, and
	 * these events are dispatched at the appropriate time. Consider for example the getter
	 * for the enabled state of the undo button, undoButtonEnabled. It's binding tag says 
	 * [Bindable(event="undoStateChanged")], which means that whenever that event is
	 * dispatched the binding system should trigger that binding and update everyone that
	 * are bound to it. The event is dispatched in the setter for undoPossible, which is
	 * where the _undoPossible variable that the getter for undoButtonEnabled uses changes
	 * (the event is dispatched in the setter for redoPossible too, just because I wanted
	 * to keep things simple and not have too many events). It may seem like a complicated
	 * way of doing something that could easily be done with plain bindable variables; the
	 * setter for undoPossible could just set the value for a undoButtonEnabled variable,
	 * and be done with it. That, however, has two downsides: firstly the undoButtonEnabled
	 * variable would become changeable from the outside of this class, which is something
	 * that you generally want to avoid. Secondly the algorithm for determining the enabled
	 * state could be more complex than being just a reflection of another value, it could
	 * depend on the value of several variables that all changed independently. Take a look
	 * at the getter for displayTitle, for example. It depends on two things: the document
	 * title and whether or not the document is unsaved ("dirty"). The getter declares this
	 * by having two bindable statements with different events. Whenever either of these
	 * events is dispatched the binding system knows that it should update everyone that
	 * are bound to the property. The code that dispatches these events doesn't need to know
	 * how to create the right value for the displayTitle, actually it doesn't even need
	 * to know about the displayTitle property at all! This is the power of loose coupling.
	 */
	public class DocumentModel extends EventDispatcher {
		
		private var _document : Document;

		private var _undoHistory : Array;
		
		private var _undoPossible  : Boolean;
		private var _redoPossible  : Boolean;
		private var _documentDirty : Boolean;
		
		private var _title : String;
		private var _text  : String;
		
		
		/** This property is injected by the application. */
		public var dispatcher : IEventDispatcher;
		
		/** This property is injected by the application. */
		public function set undoPossible( value : Boolean ) : void {
			_undoPossible = value;
			
			dispatchEvent(new Event("undoStateChanged"));
		}
		
		/** This property is injected by the application. */
		public function set redoPossible( value : Boolean ) : void {
			_redoPossible = value;
			
			dispatchEvent(new Event("undoStateChanged"));
		}
		
		/** This property is injected by the application. */
		public function set documentDirty( value : Boolean ) : void {
			_documentDirty = value;
			
			dispatchEvent(new Event("documentDirtyChanged"));
		}
		
		/**
		 * Returns the undo history sorted from the most recent command to the oldest.
		 */
		[Bindable]
		public function get undoHistory( ) : Array {
			// this may look weird, but does a few necessary things that
			// aren't easy to express in ActionScript:
			// - it avoids the possibility that the undoHistory is null
			// - it creates a copy of the array to avoid the possibility that
			//   the caller changes the list outside of this object's control
			return (_undoHistory || []).slice().reverse();
		}
		
		/** The undo history is injected by the application. */
		public function set undoHistory( value : Array ) : void {
			_undoHistory = value;
		}
		
		/**
		 * This property is injected by the application. The getter is only here because
		 * BindingUtils.bindSetter throws an error for read-only properties (see the constructor).
		 */
		[Bindable]
		public function get document( ) : Document {
			return _document;
		}
		
		public function set document( value : Document ) : void {
			_document = value;
			
			// as a side effect of this property being set the titleChanged
			// and textChanged methods will be called, because of the bindings
			// set up in the constructor
		}
		
		/*
		 * The following two properties, text and title, provide the view with a way
		 * to access the current text and title, and to set new values when the user
		 * is editing these. The setters take care of calling the update method, which
		 * notifies the application of the change.
		 */
		
		[Bindable(event="textChanged")]
		public function get text( ) : String {
			return _text || "";
		}
		
		public function set text( value : String ) : void {
			_text = value;
			
			update();
		}
		
		[Bindable(event="titleChanged")]
		public function get title( ) : String {
			return _title || "";
		}
		
		public function set title( value : String ) : void {
			_title = value;
			
			update();
		}
		
		[Bindable(event="titleChanged")]
		[Bindable(event="documentDirtyChanged")]
		public function get displayTitle( ) : String {
			return title + (_documentDirty ? " *" : "");
		}
		
		/*
		 * The following three getters encapsulate the logic that determines
		 * if the undo, redo and save buttons should be enabled. The view
		 * only needs to bind to these three, which keeps it simple.
		 */
		
		[Bindable(event="undoStateChanged")]
		public function get undoButtonEnabled( ) : Boolean {
			return _undoPossible;
		}
		
		[Bindable(event="undoStateChanged")]
		public function get redoButtonEnabled( ) : Boolean {
			return _redoPossible;
		}
		
		[Bindable(event="documentDirtyChanged")]
		public function get saveButtonEnabled( ) : Boolean {
			return _documentDirty;
		}
		
		
		
		public function DocumentModel( ) {
			// whenever the document property or the title and text properties of the
			// document changes, call the titleChanged and/or textChanged methods
			BindingUtils.bindSetter(titleChanged, this, ["document", "title"]);
			BindingUtils.bindSetter(textChanged,  this, ["document", "text"]);
		}
		
		private function titleChanged( title : String ) : void {
			_title = title;
			
			dispatchEvent(new Event("titleChanged"));
		}
		
		private function textChanged( text : String ) : void {
			_text = text;
			
			dispatchEvent(new Event("textChanged"));
		}
		
		/**
		 * Returns a prettified label for an undoable command, the label contains the
		 * index of the command in the history (1 is most recent), the description and
		 * the timestamp in HH:MM:SS format.
		 */
		public function labelForUndoable( undoable : Undoable ) : String {
			var hours   : String = (undoable.timestamp.hours   < 10 ? "0" : "") + undoable.timestamp.hours;
			var minutes : String = (undoable.timestamp.minutes < 10 ? "0" : "") + undoable.timestamp.minutes;
			var seconds : String = (undoable.timestamp.seconds < 10 ? "0" : "") + undoable.timestamp.seconds;
			var index   : int    = undoHistory.indexOf(undoable) + 1;
			
			return index + ". " + undoable.description + " (" + hours + ":" + minutes + ":" + seconds + ")";
		}
		
		/**
		 * Notifies the application that the document needs updating.
		 */
		private function update( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.UPDATE);
			
			event.reference = document;
			event.data      = new DocumentData(_title, _text);
			
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Notifies the application that the document needs saving (after first calling update).
		 */
		public function save( ) : void {
			update();
			
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.SAVE);
			
			event.reference = document;
			
			dispatcher.dispatchEvent(event);
		}

		/**
		 * Notifies the application that the user has requested an undo. When the
		 * application handles the undo request the document may change, and this
		 * will be handled as any other change in the document's state.
		 */
		public function undo( ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.UNDO));
		}
		
		/**
		 * Notifies the application that the user has requested a redo.
		 */
		public function redo( ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.REDO));
		}
		
		/**
		 * Notifies the application that the user has requested a restore.
		 */
		public function restore( undoable : Undoable ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.RESTORE, undoable));
		}
		
	}
	
}