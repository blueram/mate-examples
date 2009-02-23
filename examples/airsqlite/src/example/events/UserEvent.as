/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * 
 */

package example.events
{

	import example.models.vo.UserVO;
	
	import flash.events.Event;


	public class UserEvent extends Event {
		
		public static const ADD: String = "addUser";
		public static const DELETE: String = "deleteUser";
		public static const UPDATE: String = "updateUser";
		public static const GET_USERS: String = "getUsers";
		public static const GET_NEXT: String = "getNextCount";
		public static const INSERT_STRINGS:String = "insertStrings";
		public static const INSERT_STATEMENTS:String = "insertStatements";

		public var userId : int;
		public var userVO : UserVO;
		
		public var number:Number;

		public function UserEvent(type : String, bubbles: Boolean = false, cancelable: Boolean = false ) 
		{
			super(type, true, cancelable);
		}
		
	}
	
}