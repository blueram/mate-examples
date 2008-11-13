package flickrWidget.vos
{
	[Bindable]
	public class Photo
	{
		public var id:uint = 0;
		public var title:String = '';
		public var farmId:uint = 0;
		public var description:String = '';
		public var secret:String = '';
		public var isPublic:Boolean = false;
		public var serverId:uint = 0;
		public var userId:String = '';
		
		[Bindable (event="photoChange")]
		public function get urlSmallSquare():String 
		{
			return 'http://farm' + farmId + '.static.flickr.com/' + serverId + '/' + id + '_' + secret + '_s.jpg';
		}
		
		[Bindable (event="photoChange")]
		public function get urlMedium():String 
		{
			return 'http://farm' + farmId + '.static.flickr.com/' + serverId + '/' + id + '_' + secret + '.jpg';
		}
		
		[Bindable (event="photoChange")]
		public function get urlSmall():String 
		{
			return 'http://farm' + farmId + '.static.flickr.com/' + serverId + '/' + id + '_' + secret + '_m.jpg';
		}
		
		[Bindable (event="photoChange")]
		public function get urlThumbnail():String {
			return 'http://farm' + farmId + '.static.flickr.com/' + serverId + '/' + id + '_' + secret + '_t.jpg';
		}
		
		public function get url():String {
			return "http://www.flickr.com/photos/" + userId + "/" + id;
		}
		
	}
}