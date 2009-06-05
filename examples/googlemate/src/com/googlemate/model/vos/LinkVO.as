package com.googlemate.model.vos
{
	/**
	 *  LinkVO
	 */
	[Bindable]
	public class LinkVO
	{
		public var id: int;
		public var unescapedUrl:String = "";
		public var url:String = "";
		public var visibleUrl:String = "";
		public var title:String = "";
		public var titleNoFormatting:String = "";
		public var content:String = "";
		public var cacheUrl:String = "";
		
		[Transient]
		public var isFavorite:Boolean = true;
	}
}