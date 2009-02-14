/**
 * Fruit event class
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package demo.events
{
	import mx.events.FlexEvent;

	public class FruitEvent extends FlexEvent
	{
		public static const CREATE_FRUIT:String = "createFruitEvent";
		
		public var fruitClass:String;
		
		public function FruitEvent(type:String, fruitClass:String)
		{
			super(type, true);
			
			this.fruitClass = fruitClass;
		}
		
	}
}