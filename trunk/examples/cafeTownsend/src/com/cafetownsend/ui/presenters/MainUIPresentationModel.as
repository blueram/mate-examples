package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class MainUIPresentationModel extends EventDispatcher
	{
		private var _stackIndex:int;
		
		[Bindable(Event="stackIndexChange")]
		public function get stackIndex():int
		{
			return _stackIndex;
		}
		
		public function set navigationPath( path:String ):void
		{
			if( path == Navigation.EMPLOYEE_DETAIL ) _stackIndex = 2;
			else if( path == Navigation.EMPLOYEE_LIST ) _stackIndex = 1;
			else  _stackIndex = 0;
			
			dispatchEvent( new Event( "stackIndexChange" ) );
		}
		
	}
}