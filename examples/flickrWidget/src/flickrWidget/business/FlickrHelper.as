package flickrWidget.business
{
	import flickrWidget.vos.Photo;
	
	import mx.collections.ArrayCollection;
	
	public class FlickrHelper 
	{
		
		//..........................Properties..................
		public var apiKey:String = null;
		public var apiUrl:String = null;
		
		
		
		//..........................Methods..................
		
		// -----------------------------------------------------------
		// This function is used when searching. It checks whether user
		// or tags are provided, since flickr will not return meaninful 
		// data when sending empty user id or empty tags. 
		public function getSearchUrl(user:String, tags:String, page:uint = 1):String 
		{
			var url:String = apiUrl + "?method=flickr.photos.search&api_key=" + apiKey;
			url += "&page=" + page;
			
			if (user && user.length > 0)
				url += "&user_id=" + user;
			
			if (tags && tags.length > 0)
				url += "&tags=" + tags;
			
			return url;
		}
		
		
		// ----------------------------------------------------------
		public function parseUser(xml:XML):String 
		{
			if (xml.@stat == 'ok')
			{
				return xml.user.@id.toString();
			}
			
			return ""; 
		}
		
		// -----------------------------------------------------------
		public function parsePhotos(response:XML):ArrayCollection 
		{

			var photos:ArrayCollection = new ArrayCollection();
				
			for each( var photo:XML in response..photo ) 
			{
				var photoObj:Photo = new Photo();
				photoObj.id = photo.@id;
				photoObj.farmId = photo.@farm;
				photoObj.secret = photo.@secret;
				photoObj.serverId = photo.@server;
				photoObj.title = photo.@title;
				photoObj.isPublic = photo.@ispublic;
				photoObj.userId = photo.@owner;
				photos.addItem(photoObj);
			}
			
			return photos;
		}
	
	}
}