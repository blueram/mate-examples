package example.model {
	
	import flash.utils.ByteArray;
	

	public interface Snapshot {
		
		function get bytes( ) : ByteArray ;
		
		function get xml( ) : XML ;
		
	}

}