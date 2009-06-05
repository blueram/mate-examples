package com.googlemate.services.google
{
	import be.boulevart.google.GoogleImageSearch;
	import be.boulevart.google.events.GoogleSearchEvent;
	
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.AbstractServiceInvoker;
	import com.asfusion.mate.actions.IAction;

	public class ImageSearch extends AbstractServiceInvoker implements IAction
	{	
		public var searchString:String = "";
		public var startValue:int = 0;
		public var safeMode:String = "";
		public var size:String = "";
		public var colorization:String = "";
		public var imageType:String = "";
		public var fileType:String = "";
		public var restrictToCreativeCommons:Boolean = false;
		public var language:String = "";
		
		private var googleImageSearch:GoogleImageSearch;
		
		public function ImageSearch() 
		{
			googleImageSearch = new GoogleImageSearch();	
		}
		
		// ---------------------------------------------------------
		override protected function prepare(scope:IScope):void 
		{
			currentInstance = this;
		}
		
		// ---------------------------------------------------------
		override protected function run(scope:IScope):void 
		{
			innerHandlersDispatcher = googleImageSearch;
			
			if (resultHandlers && resultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.IMAGE_SEARCH_RESULT, resultHandlers);
			}
			
			if (faultHandlers && faultHandlers.length > 0)
			{
				createInnerHandlers(scope, GoogleSearchEvent.ON_ERROR , faultHandlers);
			}
			
			googleImageSearch.search(searchString, startValue, safeMode, size, colorization, imageType, fileType, restrictToCreativeCommons, language);
		}
	}
}