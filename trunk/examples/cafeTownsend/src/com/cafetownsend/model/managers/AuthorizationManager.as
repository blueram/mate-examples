package com.cafetownsend.model.managers
{
	import com.cafetownsend.events.*;
	import com.cafetownsend.model.constants.Authorization;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class AuthorizationManager extends EventDispatcher
	{
		// .........................................Properties......................................
		private var _status:String = Authorization.LOGUED_OUT;
		[Bindable(Event="statusChange")]
		public function get status():String
		{
			return _status;
		}
		
		//.........................................Methods..........................................
		
		public function login(username:String, password:String):Boolean 
		{
			//check hardcoded username and password
			var isLogin:Boolean = (username == 'Flex' && password == 'Mate');
			_status = isLogin ? Authorization.LOGUED : Authorization.FAILED;
			dispatchEvent( new Event( "statusChange" ) );
			return isLogin;
		}
		
		public function logout():void
		{
			_status = Authorization.LOGUED_OUT;
			dispatchEvent( new Event( "statusChange" ) );
		}
	}
}