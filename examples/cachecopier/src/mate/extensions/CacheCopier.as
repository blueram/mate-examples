/**
 * CacheCopier Mate tag - adds an existing instance of a class to the specified Mate cache
 * 
 * <mate:CacheCopier cacheKey="{AbstractClassName}" instance="{concreteInstance}" destinationCache="whatever" />
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package mate.extensions
{
	import com.asfusion.mate.actionLists.IScope;
	import com.asfusion.mate.actions.AbstractAction;
	import com.asfusion.mate.actions.IAction;
	import com.asfusion.mate.core.Cache;
	import com.asfusion.mate.core.ISmartObject;

	public class CacheCopier extends AbstractAction implements IAction
	{
		private var _cacheKey:Object;
		/**
		 * The key to use for the cache
		 */
		public function get cacheKey():Object
		{
			return _cacheKey;
		}
		public function set cacheKey(value:Object):void
		{
			_cacheKey = value;
		}

		private var _instance:Object;
		/**
		 * The instance to set in the cache
		 */
		public function get instance():Object
		{
			return _instance;
		}
		public function set instance(i:Object):void
		{
			_instance = i;
		}

		
		private var _destinationCache:String = "inherit";
		/**
		 * The destinationCache is only useful when the destination is a class. 
		 * This attribute defines which cache we will look up for a created object.
		*/
		public function get destinationCache():String
		{
			return _destinationCache;
		}
		
		[Inspectable(enumeration="local,global,inherit")]
		public function set destinationCache(value:String):void
		{
			_destinationCache = value;
		}
		
		
		/**
		 * @inheritDoc
		 */ 
		override protected function run(scope:IScope):void
		{
			//Get the actual concrete instance
            var realInstance:Object = ISmartObject(instance).getValue(scope);

            //Add it to the cache
           	Cache.addCachedInstance(cacheKey, realInstance, destinationCache, scope);
           
           var obj:Object = Cache.getCachedInstance(cacheKey, destinationCache, scope);
           	
           	//Obey Mate rules on lastReturn
			scope.lastReturn = null;
		}

	}
}