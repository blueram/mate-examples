/**
 * Abstract fruit class.  All fruit classes must extend this
 *
 * @author Collin Peters, last modified by $Author$
 * @version $Rev$ 
 * @lastmodifieddate $Date$
 */

package demo.business
{
	public class AbstractFruit
	{
		public function AbstractFruit()
		{
		}

        public function getDescription():String
        {
        	throw new Error('Abstract class - Must override getDescription');
        }
	}
}