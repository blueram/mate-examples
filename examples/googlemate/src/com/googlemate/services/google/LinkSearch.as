package com.googlemate.services.google
{
	import be.boulevart.google.GoogleWebSearch;
	import be.boulevart.google.events.GoogleSearchEvent;
	
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.AbstractServiceInvoker;
	import com.asfusion.mate.actions.IAction;

	public class LinkSearch extends AbstractServiceInvoker implements IAction
	{	
		public var searchString:String = "";
		public var startValue:int = 0;
		public var language:String = "";
		
		private var googleWebSearch:GoogleWebSearch;
		
		public function LinkSearch() 
		{
			googleWebSearch = new GoogleWebSearch();	
		}
		
		// ---------------------------------------------------------
		override protected function prepare(scope:IScope):void 
		{
			currentInstance = this;
		}
		
		// ---------------------------------------------------------
		override protected function run(scope:IScope):void 
		{
			innerHandlersDispatcher = googleWebSearch;
			
			if (resultHandlers && resultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.WEB_SEARCH_RESULT, resultHandlers);
			}
			
			if (faultHandlers && faultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.ON_ERROR , faultHandlers);
			}
			
			googleWebSearch.search(searchString, startValue, language);
		}
	}
}