package com.googlemate.services.sqllite
{
	import com.googlemate.model.vos.LinkVO;
	
	import flash.data.SQLStatement;

	/**
	 *  SQL for Links
	 */
	public class LinksSQL
	{
		/**
		 *  Create Links Table
		 */
		public static function get createLinksTable():String
		{
			return "CREATE TABLE IF NOT EXISTS links "
					+ "(" 
					+ "id INTEGER PRIMARY KEY AUTOINCREMENT, "
					+ "unescapedUrl TEXT, " 
					+ "url TEXT, " 
					+ "visibleUrl TEXT, " 
					+ "title TEXT, " 
					+ "titleNoFormatting TEXT, " 
					+ "content TEXT, " 
					+ "cacheUrl TEXT " 
					+ ")";
		}
		
		/**
		 *  Get Links
		 */
		public static function get getLinks():String
		{
			return "SELECT * FROM links";
		}

		/**
		 *  Add Link
		 */
		public function addLink( linkVO:LinkVO ):SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "INSERT INTO links VALUES(NULL,?,?,?,?,?,?,?)";
			
			sqlStatement.parameters[0] = linkVO.unescapedUrl;
			sqlStatement.parameters[1] = linkVO.url;
			sqlStatement.parameters[2] = linkVO.visibleUrl;
			sqlStatement.parameters[3] = linkVO.title;
			sqlStatement.parameters[4] = linkVO.titleNoFormatting;
			sqlStatement.parameters[5] = linkVO.content;
			sqlStatement.parameters[6] = linkVO.cacheUrl;
			
			return sqlStatement;
		}
		
		/**
		 *  Delete Link
		 */
		public static function get deleteLink():SQLStatement
		{
			var sqlStatement:SQLStatement = new SQLStatement();
			
			sqlStatement.text = "DELETE FROM links WHERE id=?";
			
			return sqlStatement;
		}
	}
}