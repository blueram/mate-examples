/* Copyright 2008 Theo Hultberg/Iconara */

package example.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	

	/**
	 * Abstract superclass of all document types.
	 */
	public class Document extends EventDispatcher {
		
		use namespace app_internal;
		
		
		private var _title : String;
		private var _text  : String;

		private var _type  : String;
		
		
		[Bindable(event="change")]
		public function get title( ) : String {
			return _title;
		}
		
		[Bindable(event="change")]
		public function get text( ) : String {
			return _text;
		}
		
		public function get type( ) : String {
			return _type;
		}


		public function Document( type : String ) {
			_type = type;
		}
		
		protected function dispatchChange( ) : void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		app_internal function setTitle( title : String ) : void {
			setTitleImpl(title);
		}
		
		/**
		 * This is the actual implementation of setTitle. Because there are problems
		 * with overriding methods in custom namespaces this method is needed to
		 * let subclasses override the setting of the title.
		 */
		protected function setTitleImpl( title : String ) : void {
			_title = title;
			
			dispatchChange();
		}

		app_internal function setText( text : String ) : void {
			setTextImpl(text);
		}
		
		/**
		 * This is the actual implementation of setText. Because there are problems
		 * with overriding methods in custom namespaces this method is needed to
		 * let subclasses override the setting of the text.
		 */
		protected function setTextImpl( text : String ) : void {
			_text = text;
			
			dispatchChange();
		}
		
		/**
		 * Create a snapshot of the current state of the document. This snapshot can
		 * be used to restore the document at a later time, for example when undoing
		 * a series of actions. To restore the document pass the snapshot to loadSnapshot.
		 */
		public function createSnapshot( ) : Snapshot {
			return new DocumentSnapshot(title, text, type);
		}

		/**
		 * Restore the document as it was at an earlier time. See createSnapshot.
		 */
		app_internal function loadSnapshot( snapshot : Snapshot ) : void {
			loadSnapshotImpl(snapshot);
		}
		
		/**
		 * This is the actual implementation of loadSnapshot. Because there are problems
		 * with overriding methods in custom namespaces this method is needed to
		 * let subclasses override the loading of snapshots.
		 */
		protected function loadSnapshotImpl( snapshot : Snapshot ) : void {
			if ( snapshot is DocumentSnapshot ) {
				var s : DocumentSnapshot = DocumentSnapshot(snapshot);
				
				setTitle(s.title);
				setText(s.text);
			} else {
				throw new ArgumentError("Unsupported snapshot type");
			}
		}
		
	}

}


import flash.utils.ByteArray;

import example.model.DocumentData;
import example.model.Snapshot;


/**
 * The document snapshot implementation. It is based on the DocumentData VO and adds the
 * type and the getters defined by the Snapshot interface.
 */
class DocumentSnapshot extends DocumentData implements Snapshot {
	
	public var type : String;
	
	
	public function get bytes( ) : ByteArray {
		var data : ByteArray = new ByteArray();
		
		data.writeObject(this);
		
		return data;
	}
	
	public function get xml( ) : XML {
		return <document type={type}><title>{title}</title><text>{text}</text></document>;
	}
	
	
	public function DocumentSnapshot( title : String, text : String, type : String ) {
		super(title, text);
		
		this.type = type;
	}
	
}