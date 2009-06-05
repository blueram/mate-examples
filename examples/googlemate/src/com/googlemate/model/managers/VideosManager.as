package com.googlemate.model.managers
{	
	import be.boulevart.google.data.GoogleVideo;

	import com.googlemate.events.SearchEvent;
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.VideoVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Event( name="videosChange", type="flash.events.Event" )]
	[Event( name="searchResultsChange", type="flash.events.Event" )]
	[Event( name="searchStringChange", type="flash.events.Event" )]
	[Event( name="searchMaxItemsChange", type="flash.events.Event" )]
	[Event( name="searchStartIndexChange", type="flash.events.Event" )]
	[Event( name="searchInProgressChange", type="flash.events.Event" )]
	
	/**
	 *  Videos Manager
	 */
	public class VideosManager extends EventDispatcher
	{	
		// ----------------------------------------------------------------------------------------------------------
		//  Public methods
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Get Videos Result 
		 */ 
		public function getVideosResult( results:Array ):void
		{
			videos = new ArrayCollection( results );

			// update favorite flags and ids in search results
			for each ( var videoVO:VideoVO in searchResults )
			{
				videoVO = isFavorite( videoVO );
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
		 * Search Videos Result 
		 */ 
		public function searchVideosResult( results:Array ):void
		{
			var newSearchResults:ArrayCollection = new ArrayCollection( results );
			
			searchStartIndex++;
			
			if ( newSearchResults.length > 0 )
			{
				for each ( var videoItem:GoogleVideo in newSearchResults )
				{
					// keep adding items to search results until the max is met
					if ( searchResults.length < searchMaxItems )
					{
						searchResults.addItem( castItemToVO( videoItem ) );
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
		 * Cast Google Video to VideoVO 
		 */ 
		private function castItemToVO( video:GoogleVideo ):VideoVO
		{
			var videoVO:VideoVO = new VideoVO();
			
			videoVO.title = video.title;	
			videoVO.unescapedUrl = video.unescapedUrl;
			videoVO.url = video.url;
			videoVO.visibleUrl = video.visibleUrl;
			videoVO.title = video.title;
			videoVO.titleNoFormatting = video.titleNoFormatting;
			videoVO.content = video.content;
			videoVO.published = video.published;
			videoVO.publisher = video.publisher;
			videoVO.duration = video.duration;
			videoVO.thumbWidth = video.thumbWidth;
			videoVO.thumbHeight = video.thumbHeight;
			videoVO.thumbUrl = video.thumbUrl;
			videoVO.playUrl = video.playUrl;
			videoVO.author = video.author;
			videoVO.viewCount = video.viewCount;
			videoVO.rating = video.rating;
			
			// update favorite flag and id
			videoVO = isFavorite( videoVO );
			
			return videoVO;
		}
		
		/**
		 * Determine if the Video is a Favorite 
		 */ 
		private function isFavorite( videoVO:VideoVO ):VideoVO
		{
			videoVO.isFavorite = false;
			
			for each ( var video:VideoVO in videos )
			{	
				if ( video.url == videoVO.url )
				{
					videoVO.id = video.id;
					videoVO.isFavorite = true;
					return videoVO;
				} 
			}
			
			return videoVO;
		}
		
		// ----------------------------------------------------------------------------------------------------------
		//  Public properties
		// ----------------------------------------------------------------------------------------------------------
		
		/**
		 * Videos
		 */ 
		private var _videos:ArrayCollection = new ArrayCollection();
		
		[Bindable( event="videosChange" )]
		public function get videos():ArrayCollection
		{
			return _videos;
		}
		
		public function set videos( value:ArrayCollection ):void
		{
			var oldValue:ArrayCollection = _videos;
			if ( oldValue != value )
			{
				_videos = value;
				dispatchEvent( new Event( "videosChange" ) );
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
		public function VideosManager()
		{

		}
	}
}