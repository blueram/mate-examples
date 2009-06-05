package com.googlemate.model.constants
{
	import flash.filesystem.File;
	
	import mx.resources.ResourceManager;
	
	public class Constants
	{
		//-----------------------------------------------------------------------------------------------------------
		//                                         Public Static Constants
		//-----------------------------------------------------------------------------------------------------------
		
		// Data Base
		public static const DB_PATH:String = File.applicationStorageDirectory.nativePath.toString() + File.separator + 'googlemate.db';
		
		// Application
		public static const APPLICATION_AUTHOR:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_AUTHOR");
		public static const APPLICATION_AUTHOR_LOGO:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_AUTHOR_LOGO");
		public static const APPLICATION_AUTHOR_URL:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_AUTHOR_URL");
		public static const APPLICATION_DEFAULT_URL:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_DEFAULT_URL");
		public static const APPLICATION_FRAMEWORK_LOGO:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_FRAMEWORK_LOGO");
		public static const APPLICATION_FRAMEWORK_URL:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_FRAMEWORK_URL");
		public static const APPLICATION_LOGO_BIG:String	= mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_LOGO_BIG");
		public static const APPLICATION_LOGO:String	= mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_LOGO");
		public static const APPLICATION_NAME:String	= mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_NAME");
		public static const APPLICATION_PRODUCT_LOGO:String	= mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_PRODUCT_LOGO");
		public static const APPLICATION_PRODUCT_URL:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_PRODUCT_URL");
		public static const APPLICATION_SPLASH_SCREEN_IMAGE:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_SPLASH_SCREEN_IMAGE");
		public static const APPLICATION_TITLE:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_TITLE");
		public static const APPLICATION_VERSION:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "APPLICATION_VERSION");
		
		// Labels
		public static const CREDITS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "CREDITS");
		public static const DELETE:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "DELETE");
		public static const DELETE_CONFIRMATION:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "DELETE_CONFIRMATION");
		public static const FAVORITES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES");
		public static const FAVORITES_ADD_LINK_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_ADD_LINK_TIP");
		public static const FAVORITES_ADD_IMAGE_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_ADD_IMAGE_TIP");
		public static const FAVORITES_ADD_VIDEO_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_ADD_VIDEO_TIP");
		public static const FAVORITES_DELETE_LINK_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_DELETE_LINK_TIP");
		public static const FAVORITES_DELETE_IMAGE_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_DELETE_IMAGE_TIP");
		public static const FAVORITES_DELETE_VIDEO_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_DELETE_VIDEO_TIP");
		public static const FAVORITES_LINKS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_LINKS");
		public static const FAVORITES_LINKS_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_LINKS_TIP");
		public static const FAVORITES_IMAGES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_IMAGES");
		public static const FAVORITES_IMAGES_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_IMAGES_TIP");
		public static const FAVORITES_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_TIP");
		public static const FAVORITES_VIDEOS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_VIDEOS");
		public static const FAVORITES_VIDEOS_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "FAVORITES_VIDEOS_TIP");
		public static const HIDE_CONTENT_AND_RETURN:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "HIDE_CONTENT_AND_RETURN");
		public static const HTML:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "HTML");
		public static const IMAGE:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "IMAGE");
		public static const IMAGES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "IMAGES");
		public static const IMAGES_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "IMAGES_TIP");
		public static const ITEMS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "ITEMS");
		public static const LINK:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "LINK");
		public static const LINKS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "LINKS");
		public static const LINKS_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "LINKS_TIP");
		public static const MAIN:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "MAIN");
		public static const NO_LINK_FAVORITES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_LINK_FAVORITES");
		public static const NO_LINK_SEARCH_RESULTS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_LINK_SEARCH_RESULTS");
		public static const NO_IMAGE_FAVORITES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_IMAGE_FAVORITES");
		public static const NO_IMAGE_SEARCH_RESULTS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_IMAGE_SEARCH_RESULTS");
		public static const NO_VIDEO_FAVORITES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_VIDEO_FAVORITES");
		public static const NO_VIDEO_SEARCH_RESULTS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "NO_VIDEO_SEARCH_RESULTS");
		public static const OPEN_CONTENT_IN_BROWSER:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "OPEN_CONTENT_IN_BROWSER");
		public static const POWERED_BY:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "POWERED_BY");
		public static const RESULTS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "RESULTS");
		public static const SEARCH:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "SEARCH");
		public static const SEARCHING_FOR_IMAGES:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "SEARCHING_FOR_IMAGES");
		public static const SEARCHING_FOR_LINKS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "SEARCHING_FOR_LINKS");
		public static const SEARCHING_FOR_VIDEOS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "SEARCHING_FOR_VIDEOS");
		public static const VIDEO:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "VIDEO");
		public static const VIDEOS:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "VIDEOS");
		public static const VIDEOS_TIP:String = mx.resources.ResourceManager.getInstance().getString("GoogleMate", "VIDEOS_TIP");	
		
		// Parameters
		public static const MAX_SEARCH_ITEMS:int = 40;
		public static const MIN_SEARCH_ITEMS:int = 8;
		public static const SPLASH_SCREEN_DELAY:int = 3;
		
		public static const HEADER_HEIGHT:int = 86;
		public static const SUB_HEADER_HEIGHT:int = 41;
	}
}