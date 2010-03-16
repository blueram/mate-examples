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
		public static const ERROR_STATE:String = "error";
		public static const DEFAULT_STATE:String = "";
		
		
		// -------------------------------------------------------
		// Setters and getters
		// -------------------------------------------------------
		//  loginStatus ...................................................
		public function set loginStatus( status:String ):void
		{
			if( status == Authorization.FAILED )
			{
				_viewState = ERROR_STATE;
			}
			else
			{
				_viewState = DEFAULT_STATE;
				if(  status == Authorization.LOGGED_IN )
				{
					dispatchEvent( new Event( "clearFields" ) );
				}
			}
			dispatchEvent( new Event( "viewStateChanged" ) );
		}
		
		//  state ...................................................
		
		public static const VIEW_STATE_CHANGED:String = 'viewStateChanged';
		
		private var _viewState:String = DEFAULT_STATE;
		[Bindable(Event="viewStateChanged")]
		public function get viewState():String
		{
			return _viewState;
		}
		
		public static const VALIDATION_CHANGED:String = "validationChange";
		
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
			else
			{
				loginStatus = Authorization.FAILED;
			}
		}
		
		
		// -------------------------------------------------------
		// Private methods
		// -------------------------------------------------------
		
		
		
		
		//  isValid  ..........................................................
		protected function isValid( userName:String, password:String ):Boolean
		{
			var validUser: Boolean = userName != null && userName.length;
			var validPassword: Boolean = password != null && password.length;
			
			_userNameErrorString = ( validUser ) ? "" : "Username is a required field.";
			_passwordErrorString = ( validPassword ) ? "" : "Password is a required field.";
			
			dispatchEvent( new Event( VALIDATION_CHANGED ) );
			
			return ( validUser  &&  validPassword );

		}
		

		
	}
}