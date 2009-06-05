package com.googlemate.events
{
	import flash.events.Event;

	/**
	 *  Search Event
	 */
	public class SearchEvent extends Event
	{
		// ----------------------------------------------------------------------------
		// 							Static constants
		// ----------------------------------------------------------------------------
		
		public static const SEARCH_LINKS:String 	= "searchLinks";
		public static const SEARCH_IMAGES:String 	= "searchImages";
		public static const SEARCH_VIDEOS:String 	= "searchVideos";
		
		// ----------------------------------------------------------------------------
		// 							Public properties
		// ----------------------------------------------------------------------------
		
		public var searchString:String = "";
		public var searchStartIndex:int = 0;
		public var searchMaxItems:int = 0;
		public var scoring:String = "";
		public var safeMode:String = "";
		public var size:String = "";
		public var colorization:String = "";
		public var imageType:String = "";
		public var fileType:String = "";
		public var restrictToCreativeCommons:Boolean = false;
		public var language:String = "";
		
		// ----------------------------------------------------------------------------
		// 							Contructor
		// ----------------------------------------------------------------------------
		
		public function SearchEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, 
									searchString:String = "",
									searchStartIndex:int = 0,
									searchMaxItems:int = 0,
									scoring:String = "",
									safeMode:String = "",
									size:String = "",
									colorization:String = "",
									imageType:String = "",
									fileType:String = "",
									restrictToCreativeCommons:Boolean = false,
									language:String = "")
		{
			super(type, bubbles, cancelable);
			
			this.searchString = searchString;
			this.searchStartIndex = searchStartIndex;
			this.searchMaxItems = searchMaxItems;
			this.scoring = scoring;
			this.safeMode = safeMode;
			this.size = size;
			this.colorization = colorization;
			this.imageType = imageType;
			this.fileType = fileType;
			this.restrictToCreativeCommons = restrictToCreativeCommons;
			this.language = language;
		}
		
	}
}