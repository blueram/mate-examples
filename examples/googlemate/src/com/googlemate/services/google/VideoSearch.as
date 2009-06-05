package com.googlemate.services.google
{
	import be.boulevart.google.GoogleVideoSearch;
	import be.boulevart.google.events.GoogleSearchEvent;
	
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.AbstractServiceInvoker;
	import com.asfusion.mate.actions.IAction;

	public class VideoSearch extends AbstractServiceInvoker implements IAction
	{	
		public var searchString:String = "";
		public var scoring:String = "";
		public var startValue:int = 0;
		public var language:String = "";
		
		private var googleVideoSearch:GoogleVideoSearch;
		
		public function VideoSearch() 
		{
			googleVideoSearch = new GoogleVideoSearch();	
		}
		
		// ---------------------------------------------------------
		override protected function prepare(scope:IScope):void 
		{
			currentInstance = this;
		}
		
		// ---------------------------------------------------------
		override protected function run(scope:IScope):void 
		{
			innerHandlersDispatcher = googleVideoSearch;
			
			if (resultHandlers && resultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.VIDEO_SEARCH_RESULT, resultHandlers);
			}
			
			if (faultHandlers && faultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.ON_ERROR , faultHandlers);
			}
			
			googleVideoSearch.search(searchString, startValue, scoring, language);
		}
	}
}