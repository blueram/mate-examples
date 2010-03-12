package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.constants.Authorization;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class LoginPresentationModel extends EventDispatcher
	{
		// -------------------------------------------------------
		// Public constants
		// -------------------------------------------------------
		public static const MESSAGE_STATE:String = "messageState";
		public static const DEFAULT_STATE:String = "";
		
		
		// -------------------------------------------------------
		// Setters and getters
		// -------------------------------------------------------
		//  loginStatus ...................................................
		public function set loginStatus( status:String ):void
		{
			if( status == Authorization.FAILED )
			{
				_state = MESSAGE_STATE;
			}
			else
			{
				_state = DEFAULT_STATE;
				if(  status == Authorization.LOGGED_IN )
				{
					dispatchEvent( new Event( "clearFields" ) );
				}
			}
			dispatchEvent( new Event( "stateChange" ) );
		}
		
		//  state ...................................................
		private var _state:String = DEFAULT_STATE;
		[Bindable(Event="stateChange")]
		public function get state():String
		{
			return _state;
		}
		
		//  passwordErrorString ...................................................
		private var _passwordErrorString:String = "";
		
		[Bindable(Event="validationChange")]
		public function get passwordErrorString():String
		{
			return _passwordErrorString
		}
		
		//  userNameErrorString ...................................................
		private var _userNameErrorString:String = "";
		
		[Bindable(Event="validationChange")]
		public function get userNameErrorString():String
		{
			return _userNameErrorString;
		}
		
		//  clearFields ...................................................
		[Bindable(Event="clearFields")]
		public function get clearFields():String
		{
			return "";
		}
		
		// -------------------------------------------------------
		// Contructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function LoginPresentationModel( dispatcher:IEventDispatcher )
		{
			this.dispatcher = dispatcher;
		}
		
		
		// -------------------------------------------------------
		// Public methods
		// -------------------------------------------------------
		
		//  login  ..........................................................
		public function login( userName:String, password:String ):void
		{
			if( isValid( userName, password) )
			{
				var event:LoginEvent = new LoginEvent( LoginEvent.LOGIN );
				event.username = userName;
				event.password = password;
				dispatcher.dispatchEvent( event );
			}
		}
		
		
		// -------------------------------------------------------
		// Private methods
		// -------------------------------------------------------
		
		//  isValid  ..........................................................
		private function isValid( userName:String, password:String ):Boolean
		{
			_userNameErrorString = ( userName != null && userName != "" ) ? "" : "Username is a required field.";
			_passwordErrorString = ( password != null && password != "" ) ? "" : "Password is a required field.";
			
			dispatchEvent( new Event( "validationChange" ) );
			
			return ( userName != null && userName != "" && password != null && password != ""  );
		}
	}
}