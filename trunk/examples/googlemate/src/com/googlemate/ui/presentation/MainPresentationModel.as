package com.googlemate.ui.presentation
{	
	import com.googlemate.events.NavigationEvent;
	import com.googlemate.model.constants.Constants;
	import com.googlemate.ui.presentation.navigation.MainViews;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.collections.ArrayCollection;
	import mx.events.ItemClickEvent;
		
	[Event( name="screenEnabledChange", type="flash.events.Event" )]
	[Event( name="navigationItemsChange", type="flash.events.Event" )]
	[Event( name="currentViewChange", type="flash.events.Event" )]
	[Event( name="locationChange", type="flash.events.Event" )]
	
	/**
	 *  Main Presentation Model
	 */
	public class MainPresentationModel extends EventDispatcher
	{
		// ----------------------------------------------------------------------------
		// Public Methods
		// ----------------------------------------------------------------------------
        
        /**
		 * Disable Screen
		 */ 
		public function disableScreen( ):void
		{
			screenEnabled = false;
		}
		
		/**
		 * Enable Screen
		 */ 
		public function enableScreen( ):void
		{
			screenEnabled = true;
		}
		
        /**
		 * Navigate to View
		 */ 
		public function navigateToView( event:NavigationEvent ):void
		{
			hideContentView();
			
			currentView = event.parent == MainViews.PARENT ? event.view : currentView;
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
	    
	    /**
		 * Show Content View
		 */ 
		public function showContentView( event:NavigationEvent ):void
		{
			location = event.location;
			
			showContent = true;
		}
		
		/**
		 * Hide Content View
		 */ 
		public function hideContentView():void
		{
			showContent = false;
		}
		
		/**
		 * Load Blank Content
		 */ 
		public function loadBlankContent():void
		{
			location = Constants.APPLICATION_DEFAULT_URL;
		}
		
		/**
		 * Show HTML Content
		 */ 
		public function showHTMLContent( location:String ):void
		{
			var navigationEvent:NavigationEvent = new NavigationEvent( NavigationEvent.SHOW_CONTENT_VIEW );
			navigationEvent.location = location;
			
			this.dispatcher.dispatchEvent( navigationEvent );
		}
		
		/**
		 * Open Browser Window
		 */ 
		public function openBrowserWindow( url:String ):void 
		{	
			var request:URLRequest = new URLRequest(url);
            navigateToURL(request);
		} 
			
        // ----------------------------------------------------------------------------
		// Private Methods
		// ----------------------------------------------------------------------------
		 
		/**
		 * Initialize Navigation Items
		 */ 
		private function initNavigationItems():void
		{
			var views:MainViews = new MainViews();
			views.initNavigation( currentView, navigationItems );
		}
		
		// ----------------------------------------------------------------------------
		// Public Properties
		// ----------------------------------------------------------------------------
		
		/**
		 * Screen Enabled
		 */
		private var _screenEnabled:Boolean = true;
		
		[Bindable(event="screenEnabledChange")]
		public function get screenEnabled():Boolean
		{
			return _screenEnabled;
		}
	
		public function set screenEnabled( value:Boolean ):void
		{
			_screenEnabled = value;
			dispatchEvent( new Event("screenEnabledChange") );
		}
		
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
		private var _currentView:int = MainViews.DEFAULT_VIEW;
		
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
		 * Show Content
		 */ 
		private var _showContent:Boolean = false;
		
		[Bindable( event="showContentChange" )]
		public function get showContent():Boolean
		{
			return _showContent;
		}
		
		public function set showContent( value:Boolean ):void
		{
			var oldValue:Boolean = _showContent;
			if ( oldValue != value )
			{
				_showContent = value;
				dispatchEvent( new Event( "showContentChange" ) );
			}
		}
		
		/**
		 * Location URL for HTML Content
		 */ 
		private var _location:String = "assets/html/loading.html";
		
		[Bindable( event="locationChange" )]
		public function get location():String
		{
			return _location;
		}
		
		public function set location( value:String ):void
		{
			var oldValue:String = _location;
			if ( oldValue != value )
			{
				_location = value;
				dispatchEvent( new Event( "locationChange" ) );
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
		public function MainPresentationModel( dispatcher:IEventDispatcher )
		{
			this.dispatcher = dispatcher;
			
			initNavigationItems();
		}
		
	} 
} 