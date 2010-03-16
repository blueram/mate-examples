package com.cafetownsend.ui.presenters
{
	import com.cafetownsend.events.LoginEvent;
	import com.cafetownsend.model.constants.Navigation;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	
	public class MainUIPresentationModel extends EventDispatcher
	{
		public static const VIEW_STATE_CHANGED:String = "viewStateChange";
		
		private var _viewState:String = Navigation.LOGIN;

		
		// -------------------------------------------------------
		// Contructor
		// -------------------------------------------------------
		
		private var dispatcher:IEventDispatcher;
		public function MainUIPresentationModel( dispatcher:IEventDispatcher ):void
		{
			this.dispatcher = dispatcher;
		}
		
		
		public function logout() : void 
		{
			var event:LoginEvent = new LoginEvent( LoginEvent.LOGOUT );
			dispatcher.dispatchEvent(event);
		}
		
		
		[Bindable(event="viewStateChange")]
		public function get viewState():String
		{
			return _viewState;
		}

		public function set navigationPath(path:String):void
		{
			//
			// get the first path value only
			var value: String = path.split("/")[0];
				
			if (_viewState != value) {			
				_viewState = value;
				dispatchEvent(new Event(VIEW_STATE_CHANGED));
			}
		}

	}
}