package com.googlemate.events
{
	import com.googlemate.model.vos.*;
	
	import flash.events.Event;

	/**
	 *  Favorite Event
	 */
	public class FavoriteEvent extends Event
	{
		// ----------------------------------------------------------------------------
		// 							Static constants
		// ----------------------------------------------------------------------------
		
		public static const ADD_FAVORITE:String 	= "addFavorite";
		public static const DELETE_FAVORITE:String 	= "deleteFavorite";
		
		public static const GET_LINKS:String 		= "getLinks";
		public static const ADD_LINK:String 		= "addLink";
		public static const DELETE_LINK:String 		= "deleteLink";
		
		public static const GET_IMAGES:String 		= "getImages";
		public static const ADD_IMAGE:String 		= "addImage";
		public static const DELETE_IMAGE:String		= "deleteImage";
		
		public static const GET_VIDEOS:String 		= "getVideos";
		public static const ADD_VIDEO:String 		= "addVideo";
		public static const DELETE_VIDEO:String 	= "deleteVideo";
		
		// ----------------------------------------------------------------------------
		// 							Public properties
		// ----------------------------------------------------------------------------
		
		public var id:int;
		
		public var linkVO:LinkVO;
		public var imageVO:ImageVO;
		public var videoVO:VideoVO;
		
		// ----------------------------------------------------------------------------
		// 							Contructor
		// ----------------------------------------------------------------------------
		
		public function FavoriteEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, 
									  id:int=-1, 
									  linkVO:LinkVO=null, 
									  imageVO:ImageVO=null, 
									  videoVO:VideoVO=null)
		{
			super(type, bubbles, cancelable);
			
			this.id = id;
			
			this.linkVO = linkVO;
			this.imageVO = imageVO;
			this.videoVO = videoVO;
		}
	}
}