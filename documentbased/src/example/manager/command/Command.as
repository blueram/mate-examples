/* Copyright 2008 Theo Hultberg/Iconara */

package example.manager.command {
	
	/**
	 * A very basic command interface that just provides an execute method.
	 * Any data that the command needs in order to do its work should be injected
	 * through the constructor or through properties.
	 */
	public interface Command {
		
		function execute( ) : void ;
		
	}
	 
}
