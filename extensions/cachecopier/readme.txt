--------------------------------------------------------------------------
CacheCopier
Extension for Mate (http://mate.asfusion.com/) providing a tag to put an
instance of an object into the cache.  Useful when you have an object that
cannot be created by Mate (in which case it would be automatically cached) such
as one created by a factory

For using the extension check out the example called 'cachecopier' hosted on
Google Code:
http://code.google.com/p/mate-examples/source/browse/trunk/examples

--------------------------------------------------------------------------
Date: 2/11/09  
Version: 0.1
Revision: $Rev: 3757 $
Author: Collin Peters (aka cadiolis) for intouchtechnology.com 
	work: cpeters intouchtechnology com
	home: collin.peters gmail com
License: License:  Mozilla Public License 1.1. // http://www.mozilla.org/MPL/MPL-1.1.html


Known Issues:
 * Once an item is put in the cache, and a MethodInvoker called on it, if the
 object is overwritten in the cache the MethodInvoker does not use the new
 item.  Rather it uses the original instance from when it was first called

History:
02/13/09	- source moved to "mate-examples" on Google Code

