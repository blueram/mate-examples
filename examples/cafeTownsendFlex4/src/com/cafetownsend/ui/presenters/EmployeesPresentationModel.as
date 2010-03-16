package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	
	public class EmployeesPresentationModel extends EventDispatcher
	{
		public static const VIEW_STATE_CHANGED:String = "viewStateChanged";
		
		private var _viewState:String;

		
		// -------------------------------------------------------
		// Contructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function EmployeesPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		
		[Bindable(event="viewStateChanged")]
		public function get viewState():String
		{
			return _viewState;
		}

		public function set navigationPath(path:String):void
		{
			//
			// get the second path value only
			var value: String = path.split("/")[1];
				
			if (_viewState != value) {			
				_viewState = value;
				dispatchEvent(new Event(VIEW_STATE_CHANGED));
			}
		}

	}
}