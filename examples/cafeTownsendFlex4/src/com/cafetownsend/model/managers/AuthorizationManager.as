package com.cafetownsend.model.managers
{
	import com.cafetownsend.events.*;
	import com.cafetownsend.model.constants.Authorization;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class AuthorizationManager extends EventDispatcher
	{
		// .........................................Properties......................................
		private var _status:String = Authorization.LOGGED_OUT;
		
		public static const STATUS_CHANGED:String = "statusChanged";
		
		[Bindable(Event="statusChanged")]
		public function get status():String
		{
			return _status;
		}
		
		//.........................................Methods..........................................
		
		public function login(username:String, password:String):Boolean 
		{
			//check hardcoded username and password
			var isLogin:Boolean = (username == 'Flex' && password == 'Mate');
			_status = isLogin ? Authorization.LOGGED_IN : Authorization.FAILED;
			dispatchEvent( new Event( STATUS_CHANGED ) );
			return isLogin;
		}
		
		public function logout():void
		{
			_status = Authorization.LOGGED_OUT;
			dispatchEvent( new Event( STATUS_CHANGED ) );
		}
	}
}