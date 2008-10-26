package de.websector.mate.extensions.air
{
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actionLists.ServiceHandlers;
	import com.asfusion.mate.actions.AbstractServiceInvoker;
	import com.asfusion.mate.actions.IAction;
	import com.asfusion.mate.core.SmartArguments;
	import com.asfusion.mate.events.UnhandledFaultEvent;
	import com.asfusion.mate.utils.debug.LogInfo;
	import com.asfusion.mate.utils.debug.LogTypes;
	
	import flash.data.SQLStatement;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	/**
	 * SQLServiceInvoker is an extention for using Mate (http://mate.asfusion.com/) with AIR and SQLite
	 * 
	 * @author 		Jens Krause [www.websector.de]
	 * @version      0.1
	 * @date         10/26/08
	 * 
	 */	
	public class SQLServiceInvoker extends AbstractServiceInvoker implements IAction
	{
		//
		// vars

		//
		// const	
		
		//
		// instances
		protected var _sqlService: SQLService;
		protected var _statement: SQLStatement;
		protected var _sql: String = '';
		protected var _itemClass: Class;
		protected var _parameters: Array;
		
				
			
		public function SQLServiceInvoker()
		{
			super();
		}


		
		override protected function prepare(scope:IScope):void
		{
			//
			// lets use scope's dispatcher for dispatching events from sqlService
			_sqlService.dispatcher 
			= innerHandlersDispatcher
			= scope.dispatcher;
			
			if(resultHandlers && resultHandlers.length > 0)
			{
				var resultHandlersInstance:ServiceHandlers = createInnerHandlers(scope,  
																				ResultEvent.RESULT, 
																				resultHandlers, 
																				ServiceHandlers)  as ServiceHandlers;
				resultHandlersInstance.validateNow();
			}
			if( (faultHandlers && faultHandlers.length > 0) || scope.dispatcher.hasEventListener(UnhandledFaultEvent.FAULT))
			{
				var faultHandlersInstance:ServiceHandlers = createInnerHandlers(scope,  
																				FaultEvent.FAULT, 
																				faultHandlers, 
																				ServiceHandlers)  as ServiceHandlers; 
				faultHandlersInstance.validateNow();
			}

			if (!instance)
			{
				var logInfo:LogInfo = new LogInfo( scope, _sqlService );
				scope.getLogger().error(LogTypes.INSTANCE_UNDEFINED, logInfo);
				return;
			}
			
			if ( statement )
				_sqlService.statement = statement;
			
		}
				
		override protected function run(scope:IScope):void
		{
			// clean up parameters which are maybe SmartObjects
			var cleanedParameters:Array;			
			if ( parameters )
			{
				cleanedParameters = (new SmartArguments()).getRealArguments(scope, this.parameters);			
			}
			
			_sqlService.execute( sql, itemClass, cleanedParameters);
		}	
		
					
		//--------------------------------------------------------------------------
		//
		// getter / setter
		//
		//--------------------------------------------------------------------------
		
		public function get instance():SQLService
		{
			return _sqlService;
		}
		public function set instance(value: SQLService):void
		{
			_sqlService = value;
		}		

		public function get statement (): SQLStatement 
		{
			return _statement;
		};		
		public function set statement (value: SQLStatement): void 
		{
			_statement = value;
		};

		public function get itemClass (): Class 
		{
			return _itemClass;
		};		
		public function set itemClass (value: Class): void 
		{
			_itemClass = value;
		};

		public function get parameters (): Array 
		{
			return _parameters;
		};		
		public function set parameters (value: Array): void 
		{
			_parameters = value;
		};

		public function get sql (): String 
		{
			return _sql;
		};		
		public function set sql (value: String): void 
		{
			_sql = value;
		};	
		
	}
}