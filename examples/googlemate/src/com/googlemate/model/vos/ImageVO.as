package com.googlemate.model.vos
{
	/**
	 *  ImageVO
	 */
	[Bindable]
	public class ImageVO
	{
		public var id: int;
		public var title:String = "";
		public var titleNoFormatting:String = "";
		public var unescapedUrl:String = "";
		public var url:String = "";
		public var visibleUrl:String = "";
		public var originalContextUrl:String = "";
		public var width:String = "";
		public var height:String = "";
		public var thumbWidth:String = "";
		public var thumbHeight:String = "";
		public var thumbUrl:String = "";
		public var content:String = "";
		public var contentNoFormatting:String = "";
		
		[Transient]
		public var isFavorite:Boolean = true;
	}
}