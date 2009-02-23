/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * 
 */
package example.models.domain
{
	import flash.data.SQLResult;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class MainModel extends EventDispatcher
	{
		private var _userData: ArrayCollection;
		
		public function MainModel()
		{
			super();
		}
		
		
		public function setUserData(data: Array):void
		{
			_userData = new ArrayCollection ( data );
			
			this.dispatchEvent( new Event('userDataChanged') );
		}
		public function addToUserData(data: SQLResult):void
		{
			if (data.data)
				_userData.source = _userData.source.concat(data.data);			
			this.dispatchEvent( new Event('userDataChanged') );
		}
		
		
		[Bindable (event='userDataChanged')]
		public function get userData ():ArrayCollection
		{
			return _userData;
		}
		
	}
}