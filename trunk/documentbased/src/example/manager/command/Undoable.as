package example.manager.command {
	
	public interface Undoable extends Command {
		
		function get timestamp( ) : Date ;
		
		function get description( ) : String ;
		
		function undo( ) : void ;
		
		function redo( ) : void ;
		
	}
	 
}
