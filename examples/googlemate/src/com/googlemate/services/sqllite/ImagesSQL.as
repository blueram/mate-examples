package com.googlemate.services.sqllite
{
	import com.googlemate.model.vos.ImageVO;
	
	import flash.data.SQLStatement;

	/**
	 *  SQL for Images
	 */
	public class ImagesSQL
	{
		/**
		 *  Create Images Table
		 */
		public static function get createImagesTable():String
		{
			return "CREATE TABLE IF NOT EXISTS images "
					+ "(" 
					+ "id INTEGER PRIMARY KEY AUTOINCREMENT, "   
					+ "title TEXT, " 
					+ "titleNoFormatting TEXT, " 
					+ "unescapedUrl TEXT, " 
					+ "url TEXT, " 
					+ "visibleUrl TEXT, " 
					+ "originalContextUrl TEXT, " 
					+ "width TEXT, "
					+ "height TEXT, "
					+ "thumbWidth TEXT, "
					+ "thumbHeight TEXT, "
					+ "thumbUrl TEXT, "
					+ "content TEXT, " 
					+ "contentNoFormatting TEXT " 
					+ ")";
		}
			
		/**
		 *  Get Images
		 */
		public static function get getImages():String
		{
			return "SELECT * FROM images";
		}

		/**
		 *  Add Image
		 */
		public function addImage( imageVO:ImageVO ):SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "INSERT INTO images VALUES(NULL,?,?,?,?,?,?,?,?,?,?,?,?,?)";

			sqlStatement.parameters[0] = imageVO.title;
			sqlStatement.parameters[1] = imageVO.titleNoFormatting;
			sqlStatement.parameters[2] = imageVO.unescapedUrl;
			sqlStatement.parameters[3] = imageVO.url;
			sqlStatement.parameters[4] = imageVO.visibleUrl;
			sqlStatement.parameters[5] = imageVO.originalContextUrl;
			sqlStatement.parameters[6] = imageVO.width;
			sqlStatement.parameters[7] = imageVO.height;
			sqlStatement.parameters[8] = imageVO.thumbWidth;
			sqlStatement.parameters[9] = imageVO.thumbHeight;
			sqlStatement.parameters[10] = imageVO.thumbUrl;
			sqlStatement.parameters[11] = imageVO.content;
			sqlStatement.parameters[12] = imageVO.contentNoFormatting;
		
			return sqlStatement;
		}
		
		/**
		 *  Delete Image
		 */
		public static function get deleteImage():SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "DELETE FROM images WHERE id=?";
			
			return sqlStatement;
		}
	}
}