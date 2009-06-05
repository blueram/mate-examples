package com.googlemate.ui.presentation
{	
	import com.googlemate.events.NavigationEvent;
	import com.googlemate.ui.presentation.navigation.FavoritesViews;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
		
	[Event( name="navigationItemsChange", type="flash.events.Event" )]
	[Event( name="currentViewChange", type="flash.events.Event" )]
	
	/**
	 *  Favorites Presentation Model
	 */
	public class FavoritesPresentationModel extends EventDispatcher
	{
		// ----------------------------------------------------------------------------
		// Public Methods
		// ----------------------------------------------------------------------------
        
        /**
		 * Navigate to View
		 */ 
		public function navigateToView( event:NavigationEvent ):void
		{
			currentView = event.parent == FavoritesViews.PARENT ? event.view : currentView;
		}
		
		/**
		* Navigate to Item
		*/ 
		public function navigateToItem( event:ItemClickEvent ):void
		{
			var navigationEvent:NavigationEvent = new NavigationEvent( NavigationEvent.NAVIGATE_TO_VIEW );
			navigationEvent.parent = event.item.parent;
			navigationEvent.view = event.item.view;
			
			this.dispatcher.dispatchEvent( navigationEvent );
		}
		
        // ----------------------------------------------------------------------------
		// Private Methods
		// ----------------------------------------------------------------------------
		 
		/**
		 * Initialize Navigation Items
		 */ 
		private function initNavigationItems():void
		{
			var views:FavoritesViews = new FavoritesViews();
			views.initNavigation( currentView, navigationItems );
		}
		
		// ----------------------------------------------------------------------------
		// Public Properties
		// ----------------------------------------------------------------------------
		
		/**
		 * Navigation Items
		 */ 
		private var _navigationItems:ArrayCollection = new ArrayCollection();
		
		[Bindable( event="navigationItemsChange" )]
		public function get navigationItems():ArrayCollection
		{
			return _navigationItems;
		}
		
		public function set navigationItems( value:ArrayCollection ):void
		{
			var oldValue:ArrayCollection = _navigationItems;
			if ( oldValue != value )
			{
				_navigationItems = value;
				dispatchEvent( new Event( "navigationItemsChange" ) );
			}
		}
		
		/**
		 * Current View
		 */ 
		private var _currentView:int = FavoritesViews.DEFAULT_VIEW;
		
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
		public function FavoritesPresentationModel( dispatcher:IEventDispatcher )
		{
			this.dispatcher = dispatcher;
			
			initNavigationItems();
		}
		
	} 
} 