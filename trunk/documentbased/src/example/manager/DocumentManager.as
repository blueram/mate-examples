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
	
	
	public class DocumentManager extends EventDispatcher {
		
		use namespace app_internal;
		
		
		private var _document : Document;
		
		private var _documentDirty : Boolean;
		
	
		[Bindable]
		public var dispatcher : IEventDispatcher;
	
		[Bindable(event="documentChanged")]	
		public function get document( ) : Document {
			return _document;
		}
		
		[Bindable(event="documentDirtyChanged")]
		public function get documentDirty( ) : Boolean {
			return _documentDirty;
		}


		private function dispatchDocumentChanged( ) : void {
			dispatchEvent(new Event("documentChanged"));
		}
		
		private function dispatchDocumentDirtyChanged( ) : void {
			dispatchEvent(new Event("documentDirtyChanged"));
		}
		
		private function onDocumentChange( event : Event ) : void {
			_documentDirty = true;
			
			dispatchDocumentDirtyChanged();
		}
		
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
		
		public function documentSaved( ) : void {
			_documentDirty = false;
			
			dispatchDocumentDirtyChanged();
		}
		
		public function update( title : String, text : String ) : void {
			exec(new UpdateDocumentCommand(_document, title, text));
		}
		
		private function exec( command : Command ) : void {
			command.execute();
			
			if ( command is Undoable ) {
				dispatcher.dispatchEvent(new UndoEvent(UndoEvent.ADD_UNDOABLE, Undoable(command)));
			}
		}

	}
	
}