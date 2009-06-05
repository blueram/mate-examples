package com.googlemate.ui.presentation
{	
	import com.googlemate.events.FavoriteEvent;
	import com.googlemate.events.MainEvent;
	import com.googlemate.events.NavigationEvent;
	import com.googlemate.events.SearchEvent;
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.LinkVO;
	import com.googlemate.ui.presentation.navigation.SearchViews;
	import com.googlemate.ui.views.common.controls.GMAlert;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.ListEvent;
	
	import nl.flexperiments.display.AirAlert;
	
	[Event( name="currentViewChange", type="flash.events.Event" )]
	[Event( name="linksChange", type="flash.events.Event" )]	
	[Event( name="searchResultsChange", type="flash.events.Event" )]
	[Event( name="searchStringChange", type="flash.events.Event" )]
	[Event( name="searchMaxItemsChange", type="flash.events.Event" )]
	[Event( name="searchStartIndexChange", type="flash.events.Event" )]
	[Event( name="searchInProgressChange", type="flash.events.Event" )]
	[Event( name="selectedItemChange", type="flash.events.Event" )]
	
	/**
	 *  Links Presentation Model
	 */
	public class LinksPresentationModel extends EventDispatcher
	{
		// ----------------------------------------------------------------------------
		// Public Methods
		// ----------------------------------------------------------------------------
	    
	    /**
		 * Search for Links
		 */ 
		public function search( event:Event=null ):void
		{		
			showSearchingView();
				
			var searchEvent:SearchEvent = new SearchEvent( SearchEvent.SEARCH_LINKS );
			
			// if a search is in progress, continue the search for the next set of items, else start a new search
			searchEvent.searchString = searchInProgress ? searchString : event.currentTarget.searchString;
			searchEvent.searchMaxItems = searchInProgress ? searchMaxItems : event.currentTarget.searchMaxItems;
			searchEvent.searchStartIndex = searchInProgress ? searchStartIndex : 0;
			
			this.dispatcher.dispatchEvent( searchEvent );
		}

		/**
		 * Show Search Results
		 */ 
		public function showSearchResults():void
		{	
			// if a search is in progress, continue the search for the next set of items, else show the results		
			searchInProgress ? search() : (searchResults.length > 0) ? showSearchResultsView() : showNoSearchResultsView();
		}
		
		/**
		 * Show Link
		 */ 
		public function showLink( event:ListEvent ):void
		{
			selectedItem = event.itemRenderer.data as LinkVO;
			
			var navigationEvent:NavigationEvent = new NavigationEvent( NavigationEvent.SHOW_CONTENT_VIEW );
			navigationEvent.location = selectedItem.url;
			
			this.dispatcher.dispatchEvent( navigationEvent );
		}
		
		/**
	     *  Add Favorite
	     */
	    public function addFavorite(event:FavoriteEvent):void
	    {
	    	var favoriteEvent:FavoriteEvent = new FavoriteEvent( FavoriteEvent.ADD_LINK );
	        favoriteEvent.linkVO = event.linkVO;
	        
	        this.dispatcher.dispatchEvent( favoriteEvent );
	    }
	    
	    /**
	     *  Delete Favorite
	     */
	    public function deleteFavorite(event:FavoriteEvent):void
	    {
	    	selectedItem = event.linkVO;
	    	
	    	disableMainScreen();
	    	
	    	var title:String = Constants.FAVORITES;
			var text:String = Constants.DELETE_CONFIRMATION;
			var button1Label:String = Constants.DELETE;
			var alert:AirAlert;

			alert = new AirAlert(); 
			alert = GMAlert.show(text, title, Alert.OK | Alert.CANCEL, deleteLink, null, Alert.OK, button1Label, "");
	    
	    	alert.addEventListener( "close", enableMainScreen, false, 0, false );
	    }
	    
        // ----------------------------------------------------------------------------
		// Private Methods
		// ----------------------------------------------------------------------------

		/**
		 * Delete Link
		 */ 
		private function deleteLink( event:* ):void
		{
			enableMainScreen();
			
			if ( event.detail == Alert.OK )
			{
				var favoriteEvent:FavoriteEvent = new FavoriteEvent( FavoriteEvent.DELETE_LINK );
		        favoriteEvent.id = selectedItem.id;
		        this.dispatcher.dispatchEvent( favoriteEvent );
			}			
		}
		
		/**
		 * Enable Main Screen
		 */ 
		private function enableMainScreen( event:*=null ):void
		{
			var mainEvent:MainEvent = new MainEvent( MainEvent.ENABLE_SCREEN );
	        this.dispatcher.dispatchEvent( mainEvent );
		}
		
		/**
		 * Disable Main Screen
		 */ 
		private function disableMainScreen():void
		{
			var mainEvent:MainEvent = new MainEvent( MainEvent.DISABLE_SCREEN );
	        this.dispatcher.dispatchEvent( mainEvent );
		}
		
		/**
		 * Show No Search Results View
		 */ 
		private function showNoSearchResultsView():void
		{
			currentView = SearchViews.NO_SEARCH_RESULTS_VIEW;
		}
		
		/**
		 * Show Searching View
		 */ 
		private function showSearchingView():void
		{
			currentView = SearchViews.SEARCHING_VIEW;
		}
		
		/**
		 * Show Search Results View
		 */ 
		private function showSearchResultsView():void
		{
			currentView = SearchViews.SEARCH_RESULTS_VIEW;
		}
		
		// ----------------------------------------------------------------------------
		// Public Properties
		// ----------------------------------------------------------------------------

		/**
		 * Current View
		 */ 
		private var _currentView:int = SearchViews.DEFAULT_VIEW;
		
		[Bindable( event="currentViewChange" )]
		public function get currentView():int
		{
			return _currentView;
		}
		
		public function set currentView( value:int ):void
		{
			var oldValue:int = _currentView;
			if ( oldValue != value )
			{
				_currentView = value;
				dispatchEvent( new Event( "currentViewChange" ) );
			}
		}
		
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

		/**
		 * Selected Item
		 */ 
		private var _selectedItem:LinkVO = new LinkVO();
		
		[Bindable( event="selectedItemChange" )]
		public function get selectedItem():LinkVO
		{
			return _selectedItem;
		}
		
		public function set selectedItem( value:LinkVO ):void
		{
			var oldValue:LinkVO = _selectedItem;
			if ( oldValue != value )
			{
				_selectedItem = value;
				dispatchEvent( new Event( "selectedItemChange" ) );
			}
		}
		
		// ----------------------------------------------------------------------------
		// Private Properties
		// ----------------------------------------------------------------------------
		
		/**
		 * Dispatcher
		 */ 
		private var dispatcher:IEventDispatcher;
		
		// ----------------------------------------------------------------------------
		// Constructor
		// ----------------------------------------------------------------------------
		
		/**
		 * Constructor
		 */
		public function LinksPresentationModel( dispatcher:IEventDispatcher )
		{
			this.dispatcher = dispatcher;
		}
		
	} 
} 