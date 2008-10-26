/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * 
 */
package example.models.manager
{
	import example.models.vo.UserVO;
	
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	
	/**
	 * SQLManager to store prepared SQLStatements for executing faster statements
	 * Based on Eric J. Feminellas ISQLStatementCache
	 * @see http://www.ericfeminella.com/blog/2008/09/29/air-sql-framework/
	 * 
	 * @author Jens Krause // www.websector.de/blog
	 * 
	 */	
	public class SQLManager
	{
		public static const DB_PATH: String = File.applicationStorageDirectory.nativePath.toString() + File.separator + 'users.sql'
		
		private var _createUserTable: SQLStatement;
		private var _addUser: SQLStatement;
		private var _getAllUsers: SQLStatement;
		private var _updateUser: SQLStatement;
		private var _deleteUser: SQLStatement;

	
		public function SQLManager()
		{
			prepareStatements();
		}
		
		private function prepareStatements():void
		{
			var sql: String;
			
			sql = "CREATE TABLE IF NOT EXISTS users (" 
				 + "userId INTEGER PRIMARY KEY AUTOINCREMENT, "   
				 + "firstName TEXT, " 
				 + "lastName TEXT " 
				 + ")";
			_createUserTable = new SQLStatement();
			_createUserTable.text = sql;		
            
			sql = "INSERT INTO users VALUES(NULL,?,?)";
			_addUser = new SQLStatement();			
			_addUser.text = sql;
			_addUser.itemClass = UserVO;
			
			sql = "SELECT * FROM users";
			_getAllUsers = new SQLStatement();
			_getAllUsers.text = sql;
			_getAllUsers.itemClass = UserVO;
			
			sql = "UPDATE users SET firstName=?,lastName=? WHERE userId=?";
			_updateUser = new SQLStatement();
			_updateUser.text = sql;
			_updateUser.itemClass = UserVO;
			
			sql = "DELETE FROM users WHERE userId=?";
			_deleteUser = new SQLStatement();
			_deleteUser.text = sql;
			_deleteUser.itemClass = UserVO;	
		}
		
		public function get createUserTable():SQLStatement
		{
			return _createUserTable;
		}
		public function get addUser():SQLStatement
		{
			return _addUser;
		}
		public function get getAllUsers():SQLStatement
		{
			return _getAllUsers;
		}
		public function get updateUser():SQLStatement
		{
			return _updateUser;
		}
		public function get deleteUser():SQLStatement
		{
			return _deleteUser;
		}
			


	}
}