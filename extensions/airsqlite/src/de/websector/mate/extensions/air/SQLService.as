package de.websector.mate.extensions.air
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	/**
	 * SQLService for using SQLServiceInvoker which is an extention for Mate (http://mate.asfusion.com/) with AIR and SQLite
	 * 
	 * @author 		Jens Krause [www.websector.de]
	 * @version      0.1
	 * @date         10/26/08
	 * 
	 */	
	public class SQLService
	{
		//
		// vars
		protected var _connection: SQLConnection;		
		protected var _databasePath: String;		
		protected var _databaseFile: File;
		
		protected var _statement: SQLStatement;
		protected var _st: SQLStatement;
		
		protected var _data: Array;
		
		protected var _autoOpen: Boolean = true;
		protected var _autoClose: Boolean = false;
		
		protected var _dispatcher: IEventDispatcher;

		//
		// const	
		
		//
		// instances
			
			
		public function SQLService()
		{
		}

 		/**
 		 * Open SQLite database connection in synchronous mode
 		 * 
 		 */
 		public function open():void
		{
			try
			{
				_databaseFile = new File( databasePath );
			}
			catch(error:Error)
			{
				throw new ArgumentError( "Invalid dataBaseFilePath OR databaseFileName");
			}
			
			_connection = new SQLConnection();
		    _connection.open( _databaseFile );	

		}


		/**
		 * Execute a sql statement in assynchronous mode for handling results and faults, which has to dispatch to SQLServiceInvoker
		 * @param sql 				SQL text
		 * @param itemClass			item class of sql statement
		 * @param parameters		parameters
		 * 
		 */ 		 
		public function execute(sql:String, itemClass:Class = null, parameters: Array = null) : void
		{
			if ( !_connection.connected )
				open();

			//
			// create a sql statement if neccessary 
			// or use a prepared statement which may created before 
			if ( _statement == null )
			{
				statement = new SQLStatement();
			}
			//
			// set sql
			if (sql != null && sql != '')  
				_statement.text = sql;
			//
			// set item class
			if (itemClass != null) 
				_statement.itemClass = itemClass;
			
			//
			// set sql parameters
			if( parameters ) 
			{
				_statement.clearParameters();			
				
				var i: int;
				var max: int = parameters.length;
				for(i=0; i< max; i++)
				{
					_statement.parameters[i] = parameters[i];
				}
			}

 			_statement.execute(); 
		}		

		/**
		 * Handling results 
		 * 
		 * @param event  	Event dispatched by statement
		 * 
		 */	
		protected function statementResultHandler(event:SQLEvent):void
		{
			_data = _statement.getResult().data;
			
			if (_autoClose)
				_connection.close();
			
			_statement = null;
			
			//
			// dispatch a ResultEvent including the data, 
			// which is listened by SQLServiceInvokers resultHandlers 
			var resultEvent: ResultEvent= ResultEvent.createEvent( _data );						
			dispatcher.dispatchEvent( resultEvent );

		}

		/**
		 * Handling errors 
		 * 
		 * @param event  	Error event dispatched by statement
		 * 
		 */		
		protected function statementErrorHandler(event: SQLErrorEvent):void
		{
			if ( _autoClose )
				_connection.close();
				
			_statement = null;	

			//
			// dispatch a Faultevent, 
			// which is listened by SQLServiceInvokers faultHandlers 				
			var faultEvent:FaultEvent = FaultEvent.createEvent( new Fault( event.errorID.toString(), event.error.toString() ) );
			dispatcher.dispatchEvent( faultEvent );
		}
		
				
		//--------------------------------------------------------------------------
		//
		// getter / setter
		//
		//--------------------------------------------------------------------------

		/**
		 * Dispatcher for dispatching Result and Fault events
		 *  
		 * @return 		Dispatcher, which is by default an EventDispatcher
		 * 
		 */		
		public function get dispatcher (): IEventDispatcher 
		{
			if (_dispatcher == null)
				_dispatcher = new EventDispatcher();
							
			return _dispatcher;
		};		
		public function set dispatcher (value: IEventDispatcher): void 
		{
			_dispatcher = value;
		};

		/**
		 * Database path
		 * 
		 */	
		public function get databasePath (): String 
		{
			return _databasePath;
		};
				
		public function set databasePath (value: String): void 
		{
			_databasePath = value;
			if ( _autoOpen )
				open();
		};			
			

		/**
		 * Flag to open the connection after setting dataBasePath. Default value is true.
		 * 
		 */	
		[Inspectable(enumeration="true,false")]
		public function set autoOpen (value: Boolean): void 
		{
			_autoOpen = value;
		};			

		/**
		 * Flag to close the connection after receiving results.
		 * Default value is false.
		 * 
		 */	
		[Inspectable(enumeration="true,false")]
		public function set autoClose (value: Boolean): void 
		{
			_autoClose = value;
		};			

		/**
		 * SQLStatement which may prepared by the application for a faster execution
		 * 
		 */	
		public function get statement (): SQLStatement 
		{
			return _statement;
		};		
		public function set statement (value: SQLStatement): void
		{
			_statement = value;
			
			_statement.sqlConnection = _connection;
			_statement.addEventListener( SQLEvent.RESULT, statementResultHandler, false, 0, true);			
			_statement.addEventListener( SQLErrorEvent.ERROR, statementErrorHandler, false, 0, true);
		};		

		/**
		 * Result data
		 * 
		 */	
		public function get data (): Array 
		{
			return _data;
		};	

	}
}