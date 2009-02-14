/**
 * Apple fruit instance
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package demo.business
{
	public class Apple extends AbstractFruit
	{
		public function Apple()
		{
			super();
		}
		
        override public function getDescription():String
        {
        	return "I am an Apple";
        }
	}
}