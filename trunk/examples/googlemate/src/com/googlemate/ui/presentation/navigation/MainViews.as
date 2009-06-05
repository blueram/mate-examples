package com.googlemate.ui.presentation.navigation
{
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.NavigationVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	/**
	 * Main Navigation Views
	 */ 
	public class MainViews
	{
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Static Constants
		//-----------------------------------------------------------------------------------------------------------

		// Grand Parent
		public static const GRAND_PARENT:String		= "";
		
		// Parent
		public static const PARENT:String			= Constants.MAIN;
		
		// Parent View
		public static const PARENT_VIEW:int			= -1;

		// Views
		public static const CREDITS_VIEW:int 		= 0;
		public static const LINKS_VIEW:int 			= 1;
		public static const IMAGES_VIEW:int			= 2;
		public static const VIDEOS_VIEW:int			= 3;
		public static const FAVORITES_VIEW:int		= 4;
		
		// Default
		public static const DEFAULT_VIEW:int 		= CREDITS_VIEW;
		
		// Labels
		public static const CREDITS:String 			= Constants.CREDITS;
		public static const LINKS:String 			= Constants.LINKS;
		public static const IMAGES:String			= Constants.IMAGES;
		public static const VIDEOS:String			= Constants.VIDEOS;
		public static const FAVORITES:String		= Constants.FAVORITES;
		
		// Tooltips
		public static const LINKS_TIP:String 		= Constants.LINKS_TIP;
		public static const IMAGES_TIP:String		= Constants.IMAGES_TIP;
		public static const VIDEOS_TIP:String		= Constants.VIDEOS_TIP;	
		public static const FAVORITES_TIP:String	= Constants.FAVORITES_TIP;
		
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Properties
		//-----------------------------------------------------------------------------------------------------------

		// navigation items
		public var links:NavigationVO = new NavigationVO();
		public var images:NavigationVO = new NavigationVO();
		public var videos:NavigationVO = new NavigationVO();
		public var favorites:NavigationVO = new NavigationVO();

		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Methods
		//-----------------------------------------------------------------------------------------------------------
		
		/**
		 * Initialize the Navigation Items
		 */ 
		public function initNavigation( view:int, navigationItems:ArrayCollection ):void
		{
			// default
			view = DEFAULT_VIEW;
			
			// links
			links.grandParent = GRAND_PARENT;
			links.parent = PARENT;
			links.parentView = PARENT_VIEW;
			links.view = LINKS_VIEW;
			links.label = LINKS;
			links.toolTip = LINKS_TIP;
			navigationItems.addItem(links);
			
			// images
			images.grandParent = GRAND_PARENT;
			images.parent = PARENT;
			images.parentView = PARENT_VIEW;
			images.view = IMAGES_VIEW;
			images.label = IMAGES;
			images.toolTip = IMAGES_TIP;
			navigationItems.addItem(images);
			
			// videos
			videos.grandParent = GRAND_PARENT;
			videos.parent = PARENT;
			videos.parentView = PARENT_VIEW;
			videos.view = VIDEOS_VIEW;
			videos.label = VIDEOS;
			videos.toolTip = VIDEOS_TIP;
			navigationItems.addItem(videos);
			
			// favorites
			favorites.grandParent = GRAND_PARENT;
			favorites.parent = PARENT;
			favorites.parentView = PARENT_VIEW;
			favorites.view = FAVORITES_VIEW;
			favorites.label = FAVORITES;
			favorites.toolTip = FAVORITES_TIP;
			navigationItems.addItem(favorites);	
		}	
	}
}