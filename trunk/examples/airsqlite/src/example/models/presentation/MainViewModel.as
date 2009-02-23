/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * @author	Ben Reynolds [ likethewolf.net ]
 */
package example.models.presentation
{
	import example.events.UserEvent;
	import example.models.vo.UserVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class MainViewModel extends EventDispatcher
	{
		
		[Bindable] public var selectedUser: UserVO;
		[Bindable] public var userData: ArrayCollection;


		// injected by MainModelMap
		public var dispatcher : IEventDispatcher;
		
				
		public function MainViewModel()
		{
			super();
		}
		
		
		public function addUser( firstName: String, lastName:String ):void
		{
			var userVO: UserVO = new UserVO();
			userVO.firstName = firstName;
			userVO.lastName = lastName;
			
			var userEvent: UserEvent = new UserEvent( UserEvent.ADD );
			userEvent.userVO = userVO;
			
			dispatcher.dispatchEvent( userEvent );
		}

		public function updateUser( firstName: String, lastName:String ):void
		{
			var userVO: UserVO = new UserVO();
			userVO.userId = selectedUser.userId;
			userVO.firstName = firstName;
			userVO.lastName = lastName;

			var userEvent: UserEvent = new UserEvent( UserEvent.UPDATE );
			userEvent.userVO = userVO;
			
			dispatcher.dispatchEvent( userEvent );
		}

		public function deleteUser():void
		{
			var userEvent: UserEvent = new UserEvent( UserEvent.DELETE );
			userEvent.userId = selectedUser.userId;
			dispatcher.dispatchEvent( userEvent );
		}
		
		/**
		 * @see prefetch parameter on the MainEventMap - limit records returned
		 */
		private function getAllUsers():void
		{
			dispatcher.dispatchEvent( new UserEvent(UserEvent.GET_USERS ) );
		}
		
		public function getNextUsers():void
		{
			// this is purely for demonstration purposes. It's actually really bad for the interface :)
			dispatcher.dispatchEvent( new UserEvent(UserEvent.GET_NEXT ) );
		}
		
		public function insertStrings(number:Number):void
		{
			var userEvent:UserEvent = new UserEvent(UserEvent.INSERT_STRINGS);
			userEvent.number = number;
			dispatcher.dispatchEvent( userEvent );
		}
		
		public function insertStatements():void
		{
			dispatcher.dispatchEvent( new UserEvent(UserEvent.INSERT_STATEMENTS ) );
		}
	}
}