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


	public class DocumentModel extends EventDispatcher {
		
		private var _document : Document;

		private var _undoHistory : Array;
		
		private var _undoPossible  : Boolean;
		private var _redoPossible  : Boolean;
		private var _documentDirty : Boolean;
		
		private var _title : String;
		private var _text  : String;
		
		
		public var dispatcher : IEventDispatcher;
		
		public function set undoPossible( value : Boolean ) : void {
			_undoPossible = value;
			
			dispatchEvent(new Event("undoStateChanged"));
		}
		
		public function set redoPossible( value : Boolean ) : void {
			_redoPossible = value;
			
			dispatchEvent(new Event("undoStateChanged"));
		}
		
		public function set documentDirty( value : Boolean ) : void {
			_documentDirty = value;
			
			dispatchEvent(new Event("documentDirtyChanged"));
		}
		
		[Bindable]
		public function get undoHistory( ) : Array {
			return (_undoHistory || []).slice().reverse();
		}
		
		public function set undoHistory( value : Array ) : void {
			_undoHistory = value;
		}
		
		[Bindable]
		public function get document( ) : Document {
			return _document;
		}
		
		public function set document( value : Document ) : void {
			_document = value;

			if ( _document != null ) {
				_title = _document.title;
				_text  = _document.text;
				
				dispatchEvent(new Event("titleChanged"));
				dispatchEvent(new Event("textChanged"));
			}
		}
		
		[Bindable(event="textChanged")]
		public function get text( ) : String {
			return _text;
		}
		
		public function set text( value : String ) : void {
			_text = value;
			
			update();
		}
		
		[Bindable(event="titleChanged")]
		public function get title( ) : String {
			return _title;
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
		
		public function labelForUndoable( undoable : Undoable ) : String {
			var hours   : String = (undoable.timestamp.hours   < 10 ? "0" : "") + undoable.timestamp.hours;
			var minutes : String = (undoable.timestamp.minutes < 10 ? "0" : "") + undoable.timestamp.minutes;
			var seconds : String = (undoable.timestamp.seconds < 10 ? "0" : "") + undoable.timestamp.seconds;
			var index   : int    = undoHistory.indexOf(undoable) + 1;
			
			return index + ". " + undoable.description + " (" + hours + ":" + minutes + ":" + seconds + ")";
		}
		
		private function update( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.UPDATE);
			
			event.reference = document;
			event.data      = new DocumentData(_title, _text);
			
			dispatcher.dispatchEvent(event);
		}
		
		public function save( ) : void {
			update();
			
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.SAVE);
			
			event.reference = document;
			
			dispatcher.dispatchEvent(event);
		}

		public function undo( ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.UNDO));
		}
		
		public function redo( ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.REDO));
		}
		
		public function restore( undoable : Undoable ) : void {
			dispatcher.dispatchEvent(new UndoEvent(UndoEvent.RESTORE, undoable));
		}
		
	}
	
}