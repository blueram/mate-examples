<cfcomponent output="false" alias="Message">

	<cfproperty name="text" type="string" default="">

	<cfscript>
		this.text = "";
	</cfscript>

	<cffunction name="init" output="false" returntype="Message">
		<cfreturn this>
	</cffunction>
	<cffunction name="getText" output="false" access="public" returntype="any">
		<cfreturn this.Text>
	</cffunction>

	<cffunction name="setText" output="false" access="public" returntype="void">
		<cfargument name="val" required="true">
		<cfset this.Text = arguments.val>
	</cffunction>



</cfcomponent>