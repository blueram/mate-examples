package com.flickrBook.business
{
	public class Config
	{
		/*-.........................................Constants............................*/
		public static const API_URL:String = 'http://api.flickr.com/services/rest/';
		// use your own key
		public static const API_KEY:String = '';
		
		
		/*-.........................................Methods...............................*/
		public function readConfig(xml:XML, data:Object):void
		{
			data.tags = xml..tags[0].toString();
			data.user = xml..user[0].toString();
		}
		
		
	}
}