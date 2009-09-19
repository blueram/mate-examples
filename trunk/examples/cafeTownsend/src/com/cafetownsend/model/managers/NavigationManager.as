package com.cafetownsend.model.managers
{
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class NavigationManager extends EventDispatcher
	{
		
		private var _navigationPath:String;
		
		[Bindable(Event="navigationChange")]
		public function get navigationPath():String
		{
			return _navigationPath;
		}
		
		public function updatePath( path:String ):void
		{
			_navigationPath = path;
			dispatchEvent( new Event( "navigationChange" ) );
		}
		
		public function updateAfterLogin( login:Boolean ):void
		{
			_navigationPath = login ? Navigation.EMPLOYEE_LIST : Navigation.LOGIN ;
			dispatchEvent( new Event( "navigationChange" ) );
		}
	}
}