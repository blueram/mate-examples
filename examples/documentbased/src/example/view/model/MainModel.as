/* Copyright 2008 Theo Hultberg/Iconara */

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
	

	/**
	 * The presentation model of MainView. 
	 * 
	 * The dispatcher, currentDocument, documents and openDocuments proeprties are injected by
	 * the application controller.
	 * 
	 * See DocumentModel for more info on how presentation models work.
	 */
	public class MainModel extends EventDispatcher {
		
		private var _currentDocument : Document;
		
		private var _documents : ICollectionView;
		
				
		/** This property is injected by the application. */
		public var dispatcher : IEventDispatcher;
		
		
		/** This property is injected by the application. */
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
		
		/** This property is injected by the application. */
		[Bindable]
		public var openDocuments : ICollectionView;
		
		/** This property is injected by the application. */
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
				

		/**
		 * Listener for CollectionEvent.COLLECTION_CHANGE events on the documents collection.
		 * Makes sure that the bindings of all properties that depend on the documents collection are triggered.
		 */
		private function onDocumentsChanged( event : CollectionEvent ) : void {
			dispatchEvent(new Event("documentsChanged"));
		}
		
		/**
		 * Returns whether or not the specified document is open. Should be used by the view
		 * instead of querying the openDocuments collection directly.
		 */
		public function isOpen( document : Document ) : Boolean {
			return openDocuments.contains(document);
		}
		
		/**
		 * Notifies the application that the user has requested that a document should be opened.
		 */
		public function openDocument( document : Document ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.OPEN);
			
			event.reference = document;
			
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Notifies the application that the user has requested the creation of a new plain document.
		 */
		public function newPlainDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CREATE_NEW);
			
			event.documentType = DocumentType.PLAIN;
			
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Notifies the application that the user has requested the creation of a new rich text document.
		 */
		public function newRichDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CREATE_NEW);
			
			event.documentType = DocumentType.RICH;
			
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Notifies the application that the user has requested that the current document should be deleted.
		 */
		public function deleteCurrentDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.DELETE);
			
			event.reference = currentDocument;
			
			dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Notifies the application that the user has requested that the current document should be closed.
		 */
		public function closeCurrentDocument( ) : void {
			var event : DocumentEvent = new DocumentEvent(DocumentEvent.CLOSE);
			
			event.reference = currentDocument;
			
			dispatcher.dispatchEvent(event);
		}

	}

}