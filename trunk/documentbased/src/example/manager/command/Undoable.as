/* Copyright 2008 Theo Hultberg/Iconara */

package example.manager.command {
	
	/**
	 * Commands that implement this interface should provide a way for undoing the
	 * actions taken in their execute method.
	 * 
	 * Undoables have a redo method in addition to execute, even though those two
	 * most often will do the same work. The default implementation may be to have
	 * redo call execute, but more complex situations may arise where some extra
	 * steps are necessary when redoing, compared to executing the command initially.
	 * 
	 * It is up to the implementation how the undoing is done. It can be done by
	 * saving a snapshot of the state of the object being modified, or just by
	 * applying the same set of actions in reverse, whichever works for the situation.
	 */
	public interface Undoable extends Command {
		
		/**
		 * The timestamp is for enabling grouping of undoables so that many undoables
		 * that were executed at almost the same time (say milliseconds apart) could
		 * be undone as one. Sometimes the user's perspecive of what consitutes one
		 * action is not the same as the application's perspective.
		 * 
		 * The timestamp should be recorded in the execute method. It should not be
		 * overwritten if the execute method runs again (for example during a redo).
		 */
		function get timestamp( ) : Date ;
		
		/**
		 * The description property is for situations where the application wants to
		 * display an undo history. It can simply return the name of the command or a
		 * proper description of the changes the command made.
		 */
		function get description( ) : String ;
	
	
		function undo( ) : void ;
		
		function redo( ) : void ;
		
	}
	 
}
