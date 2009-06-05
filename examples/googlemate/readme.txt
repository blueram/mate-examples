--------------------------------------------------------------------------
Mate/AIR Example for using Google search api's and SQLite database 
--------------------------------------------------------------------------
Date: 06/03/09  
Version: 1.0
Revision: 0
Author: Tim Hoff // http://www.timothyhoff.com/blog/ // timhoff@aol.com
License:  Mozilla Public License 1.1. // http://www.mozilla.org/MPL/MPL-1.1.html

Setup Instructions:

In order for the project code to function correctly, the compiler settings must 
be updated, after the project is imported into FB or Eclipse.  After the project
has been imported, go to Project -> Properties -> Flex Compiler

Change the Additional compiler arguments to:
-locale en_US -source-path=${DOCUMENTS}/GoogleMate/locale/{locale}

If the new project was named something other than GoogleMate, replace
that part of the source path to the name of the project.  This is necessary
in order for the compiler to know where the localization files are located.