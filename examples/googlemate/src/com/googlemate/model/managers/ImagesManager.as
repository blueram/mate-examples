package com.googlemate.model.managers
{	
	import be.boulevart.google.data.GoogleImage;
	
	import com.googlemate.events.SearchEvent;
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.ImageVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Event( name="imagesChange", type="flash.events.Event" )]
	[Event( name="searchResultsChange", type="flash.events.Event" )]
	[Event( name="searchStringChange", type="flash.events.Event" )]
	[Event( name="searchMaxItemsChange", type="flash.events.Event" )]
	[Event( name="searchStartIndexChange", type="flash.events.Event" )]
	[Event( name="searchInProgressChange", type="flash.events.Event" )]
	
	/**
	 *  Images Manager
	 */
	public class ImagesManager extends EventDispatcher
	{	
		// ----------------------------------------------------------------------------------------------------------
		//  Public methods
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Get Images Result 
		 */ 
		public function getImagesResult( results:Array ):void
		{
			images = new ArrayCollection( results );

			// update favorite flags and ids in search results
			for each ( var imageVO:ImageVO in searchResults )
			{
				imageVO = isFavorite( imageVO );
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
		 * Search Images Result 
		 */ 
		public function searchImagesResult( results:Array ):void
		{
			var newSearchResults:ArrayCollection = new ArrayCollection( results );
			
			searchStartIndex++;
			
			if ( newSearchResults.length > 0 )
			{
				for each ( var imageItem:GoogleImage in newSearchResults )
				{
					// keep adding items to search results until the max is met
					if ( searchResults.length < searchMaxItems )
					{
						searchResults.addItem( castItemToVO( imageItem ) );
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
		 * Cast Google Image to ImageVO 
		 */ 
		private function castItemToVO( image:GoogleImage ):ImageVO
		{
			var imageVO:ImageVO = new ImageVO();

			imageVO.title = image.title;
			imageVO.titleNoFormatting = image.titleNoFormatting;
			imageVO.unescapedUrl = image.unescapedUrl;
			imageVO.url = image.url
			imageVO.visibleUrl = image.visibleUrl;
			imageVO.originalContextUrl = image.originalContextUrl;
			imageVO.width = image.width;
			imageVO.height = image.height;
			imageVO.thumbWidth = image.thumbWidth;
			imageVO.thumbHeight = image.thumbHeight;
			imageVO.thumbUrl = image.thumbUrl;
			imageVO.content = image.content;
			imageVO.contentNoFormatting = image.contentNoFormatting;
			
			// update favorite flag and id
			imageVO = isFavorite( imageVO );
			
			return imageVO;
		}
		
		/**
		 * Determine if the Image is a Favorite 
		 */ 
		private function isFavorite( imageVO:ImageVO ):ImageVO
		{
			imageVO.isFavorite = false;
			
			for each ( var image:ImageVO in images )
			{	
				if ( image.url == imageVO.url )
				{
					imageVO.id = image.id;
					imageVO.isFavorite = true;
					return imageVO;
				} 
			}
			
			return imageVO;
		}
		
		// ----------------------------------------------------------------------------------------------------------
		//  Public properties
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Images
		 */ 
		private var _images:ArrayCollection = new ArrayCollection();
		
		[Bindable( event="imagesChange" )]
		public function get images():ArrayCollection
		{
			return _images;
		}
		
		public function set images( value:ArrayCollection ):void
		{
			var oldValue:ArrayCollection = _images;
			if ( oldValue != value )
			{
				_images = value;
				dispatchEvent( new Event( "imagesChange" ) );
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
		public function ImagesManager()
		{

		}
	}
}