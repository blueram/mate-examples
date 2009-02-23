/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * @author	Ben Reynolds [ likethewolf.net ]
 * 
 */
package example.models.manager
{
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * SQLManager - business logic for SQLite operations
	 * 
	 * @author Jens Krause // www.websector.de/blog
	 * @author	Ben Reynolds [ likethewolf.net ]
	 * 
	 */	
	public class SQLManager extends EventDispatcher
	{
		public static const DB_PATH: String = File.applicationStorageDirectory.nativePath.toString() + File.separator + 'users.db'
		
		private var _insertStrings:Array;
	
		public function SQLManager()
		{
			super();
		}
		
		public function get createUserTable():String
		{
			return "CREATE TABLE IF NOT EXISTS users (" 
				 + "userId INTEGER PRIMARY KEY AUTOINCREMENT, "   
				 + "firstName TEXT, " 
				 + "lastName TEXT " 
				 + ")";
		}
		
		public function get addUser():SQLStatement	// legacy SQLStatement example
		{
			var user:SQLStatement = new SQLStatement();
			user.text = "INSERT INTO users VALUES(NULL,?,?)";
			return user;
		}
		public function get getAllUsers():String
		{
			return "SELECT * FROM users";
		}
		public function get updateUser():String
		{
			return "UPDATE users SET firstName=?,lastName=? WHERE userId=?";
		}
		public function get deleteUser():String
		{
			return "DELETE FROM users WHERE userId=?";
		}
		
		public function get insertStatements():Array
		{
			var x: Number;
			var statementList:Array = new Array();
			
			//can be a combination of Strings and SQLStatements
			var clear:String = "delete from users";
			
			var user1:SQLStatement = new SQLStatement();
			user1.text = "INSERT INTO users VALUES(NULL,?,?)";
			user1.parameters[0] = "Jens";
			user1.parameters[1] = "Krause";
			
			var user2:SQLStatement  = new SQLStatement();
			user2.text = "INSERT INTO users VALUES(NULL,?,?)";
			user2.parameters[0] = "Luke";
			user2.parameters[1] = "Skywalker";
			
			statementList.push(clear, user1, user2);
			
			return statementList;
		}
		
		
		/**
		 * @see DataCopier in MainEventMap -> UserEvent.INSERT_STRINGS
		 */
		[Bindable(event="insertStringsUpdated")]
		public function get insertStrings():Array
		{
			return _insertStrings;
		}
		public function set insertStrings(value:Array):void
		{
			_insertStrings = value;
			dispatchEvent(new Event("insertStringsUpdated"));
		}
		
		/**
		 * creates (rather poor) insert statements
		 * @parameters num 		the number of rather poorly named users to insert
		 * @see MethodInvoke in MainEventMap -> UserEvent.INSERT_STRINGS
		 */
		public function setInsertStrings(num:Number):Array
		{
			// in reality, this would do all sorts of exciting business logic to create the statements.
			var strings:Array = new Array();
			for (var x:Number = 0; x<Number(num); x++)
				strings.push("INSERT INTO users VALUES(NULL, "+x.toString()+", " + x.toString()+")");
			return strings;
		}
	}
}