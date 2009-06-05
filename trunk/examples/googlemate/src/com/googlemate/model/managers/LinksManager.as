package com.googlemate.model.managers
{	
	import be.boulevart.google.data.GoogleWebItem;
	
	import com.googlemate.events.SearchEvent;
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.LinkVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Event( name="linksChange", type="flash.events.Event" )]
	[Event( name="searchResultsChange", type="flash.events.Event" )]
	[Event( name="searchStringChange", type="flash.events.Event" )]
	[Event( name="searchMaxItemsChange", type="flash.events.Event" )]
	[Event( name="searchStartIndexChange", type="flash.events.Event" )]
	[Event( name="searchInProgressChange", type="flash.events.Event" )]
	
	/**
	 *  Links Manager
	 */
	public class LinksManager extends EventDispatcher
	{	
		// ----------------------------------------------------------------------------------------------------------
		//  Public methods
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Get Links Result 
		 */ 
		public function getLinksResult( results:Array ):void
		{
			links = new ArrayCollection( results );
			
			// update favorite flags and ids in search results
			for each ( var linkVO:LinkVO in searchResults )
			{
				linkVO = isFavorite( linkVO );
			}
		}
		
		/**
		 * Initialize Search 
		 */ 
		public function initializeSearch( event:SearchEvent ):void
		{
			if ( !searchInProgress )
			{
				searchResults = new ArrayCollection();
				searchString = event.searchString;
				searchMaxItems = event.searchMaxItems;
				searchStartIndex = event.searchStartIndex;
				searchInProgress = true;
			}
		}

		/**
		 * Search Links Result 
		 */ 
		public function searchLinksResult( results:Array ):void
		{
			var newSearchResults:ArrayCollection = new ArrayCollection( results );
			
			searchStartIndex++;
			
			if ( newSearchResults.length > 0 )
			{
				for each ( var webItem:GoogleWebItem in newSearchResults )
				{
					// keep adding items to search results until the max is met
					if ( searchResults.length < searchMaxItems )
					{
						searchResults.addItem( castItemToVO( webItem ) );
						searchStartIndex++;
					}
				}	
			}
			
			// stop the search if the result length is less than the min 
			// or the length of searchResults is equal to the max
			if ( newSearchResults.length < Constants.MIN_SEARCH_ITEMS || searchResults.length == searchMaxItems )
			{
				searchInProgress = false;
			}
		}
		
		// ----------------------------------------------------------------------------------------------------------
		//  Private methods
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Cast Google Web Item to LinkVO 
		 */ 
		private function castItemToVO( link:GoogleWebItem ):LinkVO
		{
			var linkVO:LinkVO = new LinkVO();
			
			linkVO.unescapedUrl = link.unescapedUrl;
			linkVO.url = link.url;
			linkVO.visibleUrl = link.visibleUrl;
			linkVO.title = link.title;
			linkVO.titleNoFormatting = link.titleNoFormatting;
			linkVO.content = link.content;
			linkVO.cacheUrl = link.cacheUrl;
		
			// update favorite flag and id
			linkVO = isFavorite( linkVO );
			
			return linkVO;
		}
		
		/**
		 * Determine if the Link is a Favorite 
		 */ 
		private function isFavorite( linkVO:LinkVO ):LinkVO
		{
			linkVO.isFavorite = false;
			
			for each ( var link:LinkVO in links )
			{	
				if ( link.url == linkVO.url )
				{
					linkVO.id = link.id;
					linkVO.isFavorite = true;
					return linkVO;
				} 
			}
			
			return linkVO;
		}
		
		// ----------------------------------------------------------------------------------------------------------
		//  Public properties
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Links
		 */ 
		private var _links:ArrayCollection = new ArrayCollection();
		
		[Bindable( event="linksChange" )]
		public function get links():ArrayCollection
		{
			return _links;
		}
		
		public function set links( value:ArrayCollection ):void
		{
			var oldValue:ArrayCollection = _links;
			if ( oldValue != value )
			{
				_links = value;
				dispatchEvent( new Event( "linksChange" ) );
			}
		}
		
		/**
		 * Search Results
		 */ 
		private var _searchResults:ArrayCollection = new ArrayCollection();
		
		[Bindable( event="searchResultsChange" )]
		public function get searchResults():ArrayCollection
		{
			return _searchResults;
		}
		
		public function set searchResults( value:ArrayCollection ):void
		{
			var oldValue:ArrayCollection = _searchResults;
			if ( oldValue != value )
			{
				_searchResults = value;
				dispatchEvent( new Event( "searchResultsChange" ) );
			}
		}
		
		/**
		 * Search String
		 */
		private var _searchString:String = "";
		
		[Bindable(event="searchStringChange")]
		public function get searchString():String
		{
			return _searchString;
		}
	
		public function set searchString( value:String ):void
		{
			_searchString = value;
			dispatchEvent( new Event("searchStringChange") );
		}
		
		/**
		 * Search Max Items
		 */
		private var _searchMaxItems:int = Constants.MIN_SEARCH_ITEMS;
		
		[Bindable(event="searchMaxItemsChange")]
		public function get searchMaxItems():int
		{
			return _searchMaxItems;
		}
	
		public function set searchMaxItems( value:int ):void
		{
			_searchMaxItems = value;
			dispatchEvent( new Event("searchMaxItemsChange") );
		}
		
		/**
		 * Search Start Index
		 */
		private var _searchStartIndex:int = 0;
		
		[Bindable(event="searchStartIndexChange")]
		public function get searchStartIndex():int
		{
			return _searchStartIndex;
		}
	
		public function set searchStartIndex( value:int ):void
		{
			_searchStartIndex = value;
			dispatchEvent( new Event("searchStartIndexChange") );
		}
		
		/**
		 * Search in Progress
		 */
		private var _searchInProgress:Boolean = false;
		
		[Bindable(event="searchInProgressChange")]
		public function get searchInProgress():Boolean
		{
			return _searchInProgress;
		}
	
		public function set searchInProgress( value:Boolean ):void
		{
			_searchInProgress = value;
			dispatchEvent( new Event("searchInProgressChange") );
		}
		
		// ----------------------------------------------------------------------------------------------------------
		//  Constructor
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function LinksManager()
		{

		}
	}
}