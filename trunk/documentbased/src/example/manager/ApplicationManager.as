package example.manager {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	
	import example.model.Document;
	import example.model.DocumentData;
	import example.model.DocumentFactory;
	
	
	/**
	 * The ApplicationManager manages the overall state of the application, things like
	 * all documents, open documents and the current document, it also creates and deletes
	 * documents.
	 */
	public class ApplicationManager extends EventDispatcher {
		
		private var _documents : ArrayCollection;
		
		private var _openDocuments : ArrayCollection;
		
		private var _currentDocument : Document;
		
		private var _documentFactory : DocumentFactory;
		
		
		/**
		 * Returns a collection of all douments that exist within the application, 
		 * whether or not they are open or closed.
		 */
		[Bindable(event="documentsChanged")]
		public function get documents( ) : ICollectionView {
			return _documents;
		}
		
		/**
		 * Returns a collection of all open documents.
		 */
		[Bindable(event="openDocumentsChanged")]
		public function get openDocuments( ) : ICollectionView {
			return _openDocuments;
		}
		
		/**
		 * Returns the current document, i.e. the document that is the front-most
		 * opened document and the one that the user is editing.
		 */
		[Bindable(event="currentDocumentChanged")]
		public function get currentDocument( ) : Document {
			return _currentDocument;
		}
		
		/**
		 * The ApplicationManager needs a DocumentFactory instance for creating
		 * new documents, it should be injected through this setter.
		 */
		public function set documentFactory( value : DocumentFactory ) : void {
			_documentFactory = value;
		}
		
	
		public function ApplicationManager( ) {
			_documents     = new ArrayCollection();
			_openDocuments = new ArrayCollection();
		}
		
		/**
		 * Creates a new document of the specified type and opens it with openDocument.
		 */
		public function createNewDocument( type : String ) : void {
			var data : DocumentData = new DocumentData("Untitled " + (documents.length + 1), "");
			
			var d : Document = _documentFactory.createDocument(data, type);
			
			_documents.addItem(d);
			
			openDocument(d);
		}
		
		/**
		 * Puts the specified document in the list of open documents, if it's not already
		 * there. Also sets it as the current document with setCurrentDocument.
		 */
		public function openDocument( d : Document ) : void {
			if ( ! _openDocuments.contains(d) ) {
				_openDocuments.addItem(d);
			}
			
			setCurrentDocument(d);
		}
		
		/**
		 * Remoes a document from the list of open documents. If the document
		 * was also the current document, the last document in the list of open
		 * documents is set as the new current document (or none if the closed 
		 * document was the only open document).
		 * 
		 * Throws an exception if the document wasn't open.
		 */
		public function closeDocument( d : Document ) : void {
			var index : int = _openDocuments.getItemIndex(d);
			
			if ( index != -1 ) {
				_openDocuments.removeItemAt(index);
				
				if ( currentDocument == d && _openDocuments.length > 0 ) {
					setCurrentDocument(Document(_openDocuments.getItemAt(_openDocuments.length - 1)));
				} else {
					setCurrentDocument(null);
				}
			} else {
				throw new ArgumentError("Cannot close document that isn't open");
			}
		}
		
		/**
		 * Sets the specified document as the current document, see get currentDocument.
		 */
		protected function setCurrentDocument( d : Document ) : void {
			_currentDocument = d;
			
			dispatchEvent(new Event("currentDocumentChanged"));
		}
		
		/**
		 * Deletes the specified document. If the document was open it is
		 * closed using closeDocument.
		 * 
		 * Throws an exception if the document isn't among the documents
		 * managed by this manager.
		 */
		public function deleteDocument( d : Document ) : void {
			if ( _openDocuments.contains(d) ) {
				closeDocument(d);
			}
			
			var index : int = _documents.getItemIndex(d);
			
			if ( index != -1 ) {
				_documents.removeItemAt(index);
			} else {
				throw new ArgumentError("Cannot remove document that doesn't exist");
			}
		}

	}
	
}