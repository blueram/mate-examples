/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * 
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
		
		private function getAllUsers():void
		{
			dispatcher.dispatchEvent(new UserEvent(UserEvent.GET_ALL ) );
		}
		
		
	}
}