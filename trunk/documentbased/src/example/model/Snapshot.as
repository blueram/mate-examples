package example.model {
	
	import flash.utils.ByteArray;
	

	/**
	 * Classes implementing this interface represent snapshots of other object's state
	 * at a given time. The snapshot can be serialized either as ByteArray or XML.
	 * 
	 * Currently there is no way to restore a snapshot from a serialized representation.
	 */
	public interface Snapshot {
		
		function get bytes( ) : ByteArray ;
		
		function get xml( ) : XML ;
		
	}

}