package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	
	public class EmployeesPresentationModel extends EventDispatcher
	{
		public static const CURRENTSTATE_CHANGE_EVENT:String = "currentStateChange";
		
		private var _currentState:String;

		
		// -------------------------------------------------------
		// Contructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function EmployeesPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		
		[Bindable(event="currentStateChange")]
		public function get currentState():String
		{
			return _currentState;
		}

		public function set navigationPath(path:String):void
		{
			//
			// get the second path value only
			var value: String = path.split("/")[1];
				
			if (_currentState != value) {			
				_currentState = value;
				dispatchEvent(new Event(CURRENTSTATE_CHANGE_EVENT));
			}
		}

	}
}