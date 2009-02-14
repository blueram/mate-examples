/**
 * Factory class to create fruit
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package demo.business
{
	import flash.utils.getDefinitionByName;
	
	import mx.controls.Alert;
	
	public class FruitFactory
	{
		public function FruitFactory()
		{
		}

        /**
         * Simple createFruit factory method.  Rudimentary but it does the job
         */
        public static function createFruit(className:String):AbstractFruit
        {
			// Catastrophic error if no classname found
			if(className == null)
			{
			    Alert.show("Unable to load className: " + className, "Error");
   			    throw new Error("Error loading className: " + className);
			}
			
			//See if this class exists
   			var clazzRef:Class = null;
			try
			{
   			    clazzRef = getDefinitionByName(className) as Class;
			}
			catch (e:Error)
			{
				//Doesn't exist
			    Alert.show("Unable to load: " + className, "Error");
   			    throw new Error("Error loading: " + className);
   			}
                    			
			//Instantiate the class
			var fruit:AbstractFruit = AbstractFruit( new clazzRef());
			
			Alert.show('Created instance of ' + className);
			
			return fruit;
        }
	}
}