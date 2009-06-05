package com.googlemate.ui.presentation.navigation
{
	import com.googlemate.model.constants.Constants;
	import com.googlemate.model.vos.NavigationVO;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	/**
	 * Favorites Navigation Views
	 */ 
	public class FavoritesViews
	{
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Static Constants
		//-----------------------------------------------------------------------------------------------------------

		// Grand Parent
		public static const GRAND_PARENT:String	= MainViews.PARENT;
		
		// Parent
		public static const PARENT:String		= MainViews.FAVORITES;

		// Parent View
		public static const PARENT_VIEW:int		= MainViews.FAVORITES_VIEW;
		
		// Views
		public static const LINKS_VIEW:int 		= 0;
		public static const IMAGES_VIEW:int		= 1;
		public static const VIDEOS_VIEW:int		= 2;
		
		// Default
		public static const DEFAULT_VIEW:int 	= LINKS_VIEW;
		
		// Labels
		public static const LINKS:String 		= Constants.FAVORITES_LINKS;
		public static const IMAGES:String		= Constants.FAVORITES_IMAGES;
		public static const VIDEOS:String		= Constants.FAVORITES_VIDEOS;
		
		// Tooltips
		public static const LINKS_TIP:String 	= Constants.FAVORITES_LINKS_TIP;
		public static const IMAGES_TIP:String	= Constants.FAVORITES_IMAGES_TIP;
		public static const VIDEOS_TIP:String	= Constants.FAVORITES_VIDEOS_TIP;	
		
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Properties
		//-----------------------------------------------------------------------------------------------------------

		// navigation items
		public var links:NavigationVO = new NavigationVO();
		public var images:NavigationVO = new NavigationVO();
		public var videos:NavigationVO = new NavigationVO();

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
		}	
	}
}