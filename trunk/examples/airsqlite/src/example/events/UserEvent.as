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
		public static const GET_ALL: String = "getAllUser";


		public var userId : int;
		public var userVO : UserVO;

		public function UserEvent(type : String, bubbles: Boolean = false, cancelable: Boolean = false ) 
		{
			super(type, true, cancelable);
		}
		
	}
	
}