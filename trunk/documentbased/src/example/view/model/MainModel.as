package example.view.model {
	
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	
	import mx.collections.ICollectionView;
	import mx.collections.ArrayCollection;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import example.model.Document;
	import example.model.DocumentType;
	
	import example.event.DocumentEvent;
	

	public class MainModel extends EventDispatcher {
		
		private var _currentDocument : Document;
		
		private var _documents : ICollectionView;
		
				
		public var dispatcher : IEventDispatcher;
		
		
		[Bindable(event="documentsChanged")]
		public function get documents( ) : ICollectionView {
			return _documents;
		}
		
		public function set documents( value : ICollectionView ) : void {
			if ( _documents != value ) {
				if ( _documents != null ) {
					_documents.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onDocumentsChanged);
				}
			
				_documents = value;
			
				if ( _documents != null ) {
					_documents.addEventListener(CollectionEvent.COLLECTION_CHANGE, onDocumentsChanged);
				}
			
				dispatchEvent(new Event("documentsChanged"));
			}
		}
		
		[Bindable]
		public var openDocuments : ICollectionView;
		
		[Bindable(event="currentDocumentChanged")]
		public function get currentDocument( ) : Document {
			return _currentDocument;
		}
		
		public function set currentDocument( value : Document ) : void {
			_currentDocument = value;
			
			dispatchEvent(new Event("currentDocumentChanged"));
		}
		
		[Bindable(event="documentsChanged")]
		public function get openSelectorEnabled( ) : Boolean {
			return documents != null && documents.length > 0;
		}
		
		[Bindable(event="currentDocumentChanged")]
		public function get closeButtonEnabled( ) : Boolean {
			return _currentDocument != null;
		}
		
		[Bindable(event="currentDocumentChanged")]
		public function get deleteButtonEnabled( ) : Boolean {
			return _currentDocument != null;
		}
				

		private function onDocumentsChanged( event : CollectionEvent ) : void {
			dispatchEvent(new Event("documentsChanged"));
		}
		
		public function isOpen( document : Document ) : Boolean {
			return openDocuments.contains(document);
		}
		
		public function openDocument( document : Document ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.OPEN);
			
			event.reference = document;
			
			dispatcher.dispatchEvent(event);
		}
		
		public function newPlainDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CREATE_NEW);
			
			event.documentType = DocumentType.PLAIN;
			
			dispatcher.dispatchEvent(event);
		}
		
		public function newRichDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CREATE_NEW);
			
			event.documentType = DocumentType.RICH;
			
			dispatcher.dispatchEvent(event);
		}
		
		public function deleteCurrentDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.DELETE);
			
			event.reference = currentDocument;
			
			dispatcher.dispatchEvent(event);
		}
		
		public function closeCurrentDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CLOSE);
			
			event.reference = currentDocument;
			
			dispatcher.dispatchEvent(event);
		}

	}

}