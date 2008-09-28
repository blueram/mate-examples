/* Copyright 2008 Theo Hultberg/Iconara */

package example.manager.command {

	import example.model.Document;
	import example.model.Snapshot;
	import example.model.app_internal;
	

	public class UpdateDocumentCommand implements Undoable {
		
		use namespace app_internal;
		
		
		private var _timestamp : Date;
		
		private var undoSnapshot : Snapshot;
		
		private var document : Document;
		
		private var title : String;
		private var text  : String;
		

		public function get timestamp( ) : Date {
			return _timestamp;
		}
		
		public function get description( ) : String {
			return "Update document";
		}
		
		
		public function UpdateDocumentCommand( document : Document, title : String, text : String ) {
			this.document = document;
			this.title    = title;
			this.text     = text;
		}
		
		public function execute( ) : void {
			undoSnapshot = document.createSnapshot();
			
			document.setTitle(title);
			document.setText(text);
			
			if ( _timestamp == null ) {
				// don't overwrite the timestamp on redo
				
				_timestamp = new Date();
			}
		}
		
		public function undo( ) : void {
			document.loadSnapshot(undoSnapshot);
		}
		
		public function redo( ) : void {
			execute();
		}

	}

}