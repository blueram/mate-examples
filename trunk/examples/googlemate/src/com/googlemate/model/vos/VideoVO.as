package com.googlemate.model.vos
{
	/**
	 *  VideoVO
	 */
	[Bindable]
	public class VideoVO
	{
		public var id: int;
		public var unescapedUrl:String = "";
		public var url:String = "";
		public var visibleUrl:String = "";
		public var title:String = "";
		public var titleNoFormatting:String = "";
		public var content:String = "";
		public var published:String = "";
		public var publisher:String = "";
		public var duration:String = "";
		public var thumbWidth:String = "";
		public var thumbHeight:String = "";
		public var thumbUrl:String = "";
		public var playUrl:String = "";
		public var author:String = "";
		public var viewCount:String = "";
		public var rating:String = "";
		
		[Transient]
		public var isFavorite:Boolean = true;
	}
}