package com.googlemate.services.sqllite
{
	import com.googlemate.model.vos.VideoVO;
	
	import flash.data.SQLStatement;

	/**
	 *  SQL for Videos
	 */
	public class VideosSQL
	{
		/**
		 *  Create Videos Table
		 */
		public static function get createVideosTable():String
		{
			return "CREATE TABLE IF NOT EXISTS videos "
					+ "(" 
					+ "id INTEGER PRIMARY KEY AUTOINCREMENT, "
					+ "unescapedUrl TEXT, " 
					+ "url TEXT, " 
					+ "visibleUrl TEXT, " 
					+ "title TEXT, " 
					+ "titleNoFormatting TEXT, " 
					+ "content TEXT, " 
					+ "published TEXT, "
					+ "publisher TEXT, "
					+ "duration TEXT, "
					+ "thumbWidth TEXT, "
					+ "thumbHeight TEXT, "
					+ "thumbUrl TEXT, "
					+ "playUrl TEXT, "
					+ "author TEXT, "
					+ "viewCount TEXT, "
					+ "rating TEXT " 
					+ ")";
		}
			
		/**
		 *  Get Videos
		 */
		public static function get getVideos():String
		{
			return "SELECT * FROM videos";
		}

		/**
		 *  Add Video
		 */
		public function addVideo( videoVO:VideoVO ):SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "INSERT INTO videos VALUES(NULL,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

			sqlStatement.parameters[0] = videoVO.unescapedUrl;
			sqlStatement.parameters[1] = videoVO.url;
			sqlStatement.parameters[2] = videoVO.visibleUrl;
			sqlStatement.parameters[3] = videoVO.title;
			sqlStatement.parameters[4] = videoVO.titleNoFormatting;
			sqlStatement.parameters[5] = videoVO.content;
			sqlStatement.parameters[6] = videoVO.published;
			sqlStatement.parameters[7] = videoVO.publisher;
			sqlStatement.parameters[8] = videoVO.duration;
			sqlStatement.parameters[9] = videoVO.thumbWidth;
			sqlStatement.parameters[10] = videoVO.thumbHeight;
			sqlStatement.parameters[11] = videoVO.thumbUrl;
			sqlStatement.parameters[12] = videoVO.playUrl;
			sqlStatement.parameters[13] = videoVO.author;
			sqlStatement.parameters[14] = videoVO.viewCount;
			sqlStatement.parameters[15] = videoVO.rating;
		
			return sqlStatement;
		}
		
		/**
		 *  Delete Video
		 */
		public static function get deleteVideo():SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "DELETE FROM videos WHERE id=?";
			
			return sqlStatement;
		}
	}
}