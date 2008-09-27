package example.manager {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	
	import example.model.Document;
	import example.model.PlainDocument;
	import example.model.DocumentType;
	import example.model.DocumentFactory;
	
	
	public class ApplicationManager extends EventDispatcher {
		
		private var _documents : ArrayCollection;
		
		private var _openDocuments : ArrayCollection;
		
		private var _currentDocument : Document;
		
		private var _documentFactory : DocumentFactory;
		
		
		public function set documentFactory( value : DocumentFactory ) : void {
			_documentFactory = value;
		}
		
		[Bindable(event="documentsChanged")]
		public function get documents( ) : ICollectionView {
			return _documents;
		}
		
		[Bindable(event="openDocumentsChanged")]
		public function get openDocuments( ) : ICollectionView {
			return _openDocuments;
		}
		
		[Bindable(event="currentDocumentChanged")]
		public function get currentDocument( ) : Document {
			return _currentDocument;
		}
		
	
		public function ApplicationManager( ) {
			_documents     = new ArrayCollection();
			_openDocuments = new ArrayCollection();
		}
		
		public function createNewDocument( type : String ) : void {
			var d : Document = _documentFactory.createDocument("Untitled " + (documents.length + 1), "", type);
			
			_documents.addItem(d);
			
			openDocument(d);
		}
		
		public function openDocument( d : Document ) : void {
			if ( ! _openDocuments.contains(d) ) {
				_openDocuments.addItem(d);
			}
			
			setCurrentDocument(d);
		}
		
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
		
		public function setCurrentDocument( d : Document ) : void {
			_currentDocument = d;
			
			dispatchEvent(new Event("currentDocumentChanged"));
		}
		
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