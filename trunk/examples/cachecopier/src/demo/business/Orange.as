/**
 * Orange fruit instance
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package demo.business
{
	public class Orange extends AbstractFruit
	{
		public function Orange()
		{
			super();
		}
		
        override public function getDescription():String
        {
        	return "I am an Orange";
        }
	}
}