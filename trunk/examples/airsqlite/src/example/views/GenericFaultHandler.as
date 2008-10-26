/**
 * Mate extensions called "SQLService" and "SQLServiceInvokerfor" using AIR and SQLite
 * 
 * @author	Jens Krause [ www.websector.de/blog ]
 * 
 */
package example.views
{
	import mx.controls.Alert;
	
	public class GenericFaultHandler
	{
		public function GenericFaultHandler()
		{
		}
		
		public function handleFault( message: String ):void
		{
			Alert.show( message );
		}

	}
}