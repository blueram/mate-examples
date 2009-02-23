package de.websector.mate.extensions.air
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	/**
	 * SQLService for using SQLServiceInvoker which is an exention for Mate (http://mate.asfusion.com/) 
	 * 
	 * @author 		Jens Krause [www.websector.de]
	 * @version      0.1
	 * @date         10/04/08
	 * @author		Ben Reynolds [ likethewolf.net ]
	 * @version		0.2
	 * @date		2009-02-20
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
		protected var _statementArray: Array;	
		protected var _prefetch:Number;
		protected var _autoOpen: Boolean = true;
		protected var _autoClose: Boolean = false;	// only one connection to a single SQLite DB can
                                                    // be active at a time. Closing it means that 
                                                    // the SQLStatement.next() method will not work
		protected var _dispatcher: IEventDispatcher;

		protected var _results:SQLResult;
		//
		// const	
		
		//
		// instances
			
			
		public function SQLService(dbPath:String = null)
		{
			if (dbPath)
				databasePath = dbPath;
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
				throw new ArgumentError( "Invalid dataBaseFilePath OR databaseFileName" );
			}
			
			_connection = new SQLConnection();
		    _connection.open( _databaseFile );	

		}


		/**
		 * Execute a sql statement in synchronous mode for handling results and faults, which has to dispatch to SQLServiceInvoker
		 * @param sql				SQL text string
		 * @param itemClass			item class returned from an sql query
		 * @param parameters		parameters to apply to the SQL string
		 * @returns					nothing
		 */
		public function execute(sql:String = null, itemClass:Class = null, parameters: Array = null):void
		{
			var x:Number;
			if ( !_connection.connected )	// gotta be in it to win it
				open();
			
			if (_statement)	// called from a statement set in the invoker (legacy)
			{
				if (!_statement.sqlConnection)	// potentially allows for separate connections if already set?
					_statement.sqlConnection = _connection;
				if (itemClass)	// apply itemClass	(again?)
					_statement.itemClass = itemClass;
				if (parameters)	// replace parameters of the SQLStatement (???)
				{
					_statement.clearParameters();
					for (x = 0; x < parameters.length; x++)
						_statement.parameters[x] = parameters[x];
				}
				_statement.execute(_prefetch);
			}
			else if (_statementArray is Array)	// an array of SQLStatements or strings set in the invoker
			{
				_statement = new SQLStatement();	// a clean SQLStatement without listeners for strings
				_statement.sqlConnection = _connection;
				
				_connection.begin();	// begin transaction
				for each (var sm:Object in _statementArray)	// loop over elements in array
				{					
					if (sm is SQLStatement)	// execute statements
					{
						SQLStatement(sm).sqlConnection = _connection;
						SQLStatement(sm).execute();
					}
					else if (sm is String)	// build and execute statements from strings
					{
						_statement.text = sm as String;
						_statement.execute();
					}
				}	
				_connection.commit(new Responder(statementResultHandler));
				
			}
			else if (sql && sql.length > 0)	// create SQLStatement with string passed in from the invoker
			{
				statement = new SQLStatement();	// clean SQLStatement
				_statement.text = sql;
				if (itemClass)	// apply itemClass (for select queries)
					_statement.itemClass = itemClass;
				if (parameters)	// apply parameters
					for (x = 0; x < parameters.length; x++)
						_statement.parameters[x] = parameters[x];
				_statement.execute(_prefetch);
			}
		}
		

		/**
		 * Handling results 
		 * 
		 * @param event  	Event dispatched by execute()
		 * 
		 */	
		protected function statementResultHandler(event:SQLEvent):void
		{
			_results = _statement.getResult();
			if (_autoClose)
				_connection.close();

			// clear if only a partial result set obtained
			if (_prefetch == -1 || _autoClose || _results.complete) 
				_statement = null;
			
			// dispatch a ResultEvent including the result, 
			// which is listened by SQLServiceInvokers resultHandlers 
			var resultEvent: ResultEvent= ResultEvent.createEvent( _results );						
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

			// dispatch a Faultevent, 
			// which is listened by SQLServiceInvokers faultHandlers 				
			var faultEvent:FaultEvent = FaultEvent.createEvent( new Fault( event.errorID.toString(), event.error.toString() ) );
			dispatcher.dispatchEvent( faultEvent );
		}
		
		public function next():void
		{
			if (_statement)
				_statement.next(_prefetch);
			else
			{
				var resultEvent:ResultEvent = ResultEvent.createEvent( new SQLResult(null) );						
				dispatcher.dispatchEvent( resultEvent );
			}
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
		}
		public function set dispatcher (value: IEventDispatcher): void 
		{
			_dispatcher = value;
		}

		/**
		 * Database path
		 * 
		 */	
		public function get databasePath (): String 
		{
			return _databasePath;
		}
				
		public function set databasePath (value: String): void 
		{
			_databasePath = value;
			if ( _autoOpen )
				open();
		}	
			

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
			if (value)
			{
				_statement.sqlConnection = _connection;
				_statement.addEventListener( SQLEvent.RESULT, statementResultHandler, false, 0, true);			
				_statement.addEventListener( SQLErrorEvent.ERROR, statementErrorHandler, false, 0, true);
			}
		};
		
		public function get statementArray (): Array 
		{
			return _statementArray;
		}	
		public function set statementArray (value: Array): void
		{
			_statementArray = value;
		}
		
		public function get prefetch(): Number 
		{
			return _prefetch;
		}
		public function set prefetch(value: Number): void
		{
			_prefetch = value;
		}

		public function get results(): SQLResult 
		{
			return _results;
		}

	}
}