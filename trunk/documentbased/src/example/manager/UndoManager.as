package example.manager {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import example.manager.command.Undoable;
	

	public class UndoManager extends EventDispatcher {
		
		private var undoStack : Array;
		private var redoStack : Array;


		[Bindable(event="undoChanged")]
		public function get undoPossible( ) : Boolean {
			return undoStack.length > 0;
		}
		
		[Bindable(event="undoChanged")]
		public function get redoPossible( ) : Boolean {
			return redoStack.length > 0;
		}
		
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
		
		public function addUndoable( undoable : Undoable ) : void {
			undoStack.push(undoable);
			redoStack = [ ];
			
			dispatchUndoChanged();
		}
		
		public function restore( undoable : Undoable ) : void {
			if ( undoStack.indexOf(undoable) > -1 ) {
				while ( redoStack[redoStack.length - 1] != undoable ) {
					undo();
				}
			} else {
				throw new ArgumentError("Cannot restore because the undoable object specified is not part of the undo history");
			}
		}
		
		public function undo( ) : void {
			if ( undoPossible ) {				
				var command : Undoable = undoStack.pop();
			
				command.undo();
			
				redoStack.push(command);
			
				dispatchUndoChanged();
			}
		}
		
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