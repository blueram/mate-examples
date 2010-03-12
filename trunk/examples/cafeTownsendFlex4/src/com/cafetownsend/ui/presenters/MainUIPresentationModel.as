package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	
	public class MainUIPresentationModel extends EventDispatcher
	{
		public static const CURRENTSTATE_CHANGE_EVENT:String = "currentStateChange";
		
		private var _currentState:String = Navigation.LOGIN;
		

		[Bindable(event="currentStateChange")]
		public function get currentState():String
		{
			return _currentState;
		}

		public function set navigationPath(value:String):void
		{
			if (_currentState != value) {
				_currentState = value;
				dispatchEvent(new Event(CURRENTSTATE_CHANGE_EVENT));
			}
		}

	}
}