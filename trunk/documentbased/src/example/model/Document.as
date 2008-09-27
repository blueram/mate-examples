package example.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	

	/**
	 * Abstract superclass of all document types.
	 * 
	 * Notes on the implementation: This should be an interface, but interfaces can't 
	 * declare namespaced methods. Moreover there is problems with the namespaced
	 * methods because of an apparent bug in the compiler, it doesn't allow namespaced
	 * methods to be overridden, so instead I've had to create protected doubles of
	 * the namespaced methods so that subclasses can override and implement these instead.
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
		
		protected function setTitleImpl( title : String ) : void {
			_title = title;
			
			dispatchChange();
		}

		app_internal function setText( text : String ) : void {
			setTextImpl(text);
		}
		
		protected function setTextImpl( text : String ) : void {
			_text = text;
			
			dispatchChange();
		}
		
		public function createSnapshot( ) : Snapshot {
			return new DocumentSnapshot(title, text, type);
		}

		app_internal function loadSnapshot( snapshot : Snapshot ) : void {
			loadSnapshotImpl(snapshot);
		}
		
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