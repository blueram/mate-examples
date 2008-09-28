package example.manager {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import example.manager.command.Undoable;
	

	/**
	 * The UndoManager keeps a stack of all the (undoable) commands that have
	 * been executed, and provides an interface for interacting with this
	 * command history.
	 * 
	 * Once a command is undone it is placed on the redo stack, and vice-versa. If
	 * a command is undone and another command is added to the undo stack before
	 * redo is called the redo stack is cleared. 
	 * 
	 * The current implementation keeps an infinite history, which probably isn't
	 * a very good idea in the long run.
	 * 
	 * The current implementation also ignores the timestamp property of Undoable,
	 * which is unfortunate. The timestamp makes it possible to group undoables so
	 * that those that were performed at almost the same time, just milliseconds
	 * apart, could be undone at the same time. Take typing a text as an example:
	 * each keystroke is an undoable action, but the user may not expect or want
	 * to have to undo each keystroke separately. Instead of implementing an
	 * algorithm that only creates an undoable command at certain intervals, this
	 * could be done automatically here in the undo manager by undoing all commands
	 * that were executed within the x milliseconds of the command that is being
	 * undone.
	 */
	public class UndoManager extends EventDispatcher {
		
		private var undoStack : Array;
		private var redoStack : Array;


		/** Undo is possible if there are undoable commands in the stack. */
		[Bindable(event="undoChanged")]
		public function get undoPossible( ) : Boolean {
			return undoStack.length > 0;
		}
		
		/**
		 * Redo is possible if there are undoable commands in the redo stack, 
		 * i.e. if any command have been undone.
		 */
		[Bindable(event="undoChanged")]
		public function get redoPossible( ) : Boolean {
			return redoStack.length > 0;
		}
		
		/**
		 * Returns a copy of the undo stack. This can be used to display the undo
		 * history and provide a way to jump multiple steps back in the undo history at once.
		 * 
		 * The commands in the history are sorted from the oldest to the newest.
		 */
		[Bindable(event="undoChanged")]
		public function get history( ) : Array {
			return undoStack.slice();
		}
		
		
		public function UndoManager( ) {
			undoStack = [ ];
			redoStack = [ ];
		}
		
		private function dispatchUndoChanged( ) : void {
			dispatchEvent(new Event("undoChanged"));
		}
		
		/**
		 * Once an undoable command is executed it should be added to the undo manager using
		 * this method.
		 * 
		 * This method clears the redo stack, because adding a new undoable after and undo forks
		 * the undo history, and the state of the application is no longer the same as it was when
		 * the commands on the redo stack were executed originally.
		 */
		public function addUndoable( undoable : Undoable ) : void {
			undoStack.push(undoable);
			redoStack = [ ];
			
			dispatchUndoChanged();
		}
		
		/**
		 * This method provides a way to jump an arbitrary number of steps back in the undo history.
		 */
		public function restore( undoable : Undoable ) : void {
			if ( undoStack.indexOf(undoable) > -1 ) {
				while ( redoStack[redoStack.length - 1] != undoable ) {
					// undo until the newest command on the redo stack is the target command
					
					undo();
					
					// this could most certainly be implemented more efficiently, for example
					// placing all commands on the undo stack on the redo stack until the 
					// target undoable was found, call undo on that command and place it on
					// the redo stack, but we'll save that for when we see the need
				}
			} else {
				throw new ArgumentError("Cannot restore because the undoable object specified is not part of the undo history");
			}
		}
		
		/**
		 * Undo the most recently added command. The command is placed on the redo stack.
		 */
		public function undo( ) : void {
			if ( undoPossible ) {				
				var command : Undoable = undoStack.pop();
			
				command.undo();
			
				redoStack.push(command);
			
				dispatchUndoChanged();
			}
		}
		
		/**
		 * Redo the most recently undone command. The command is placed on the undo stack.
		 */
		public function redo( ) : void {
			if ( redoPossible ) {
				var command : Undoable = redoStack.pop();

				command.redo();
			
				undoStack.push(command);
			
				dispatchUndoChanged();
			}
		}

	}

}