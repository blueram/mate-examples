<!--- 

   EXAMPLE: Hello World
   AUTHOR: AsFusion (Nahuel Foronda and Laura Arguello)
   CREATED: Dec. 8, 2005

   Macromedia® Flex® by Example
   http://www.ifbin.com

---> 

<cfcomponent name="HelloWorldService" displayname="HelloWorld" 
			hint="A simple service that says 'Hello'' to the caller in a number of different ways">

	<!--- make an array of greeting strings, with a variable %name% that will later be substituted by the user's' name --->
	<cfset variables.greetings = arraynew(1) />
	<cfset variables.greetings[1] = "Hello %name%!" />
	<cfset variables.greetings[2] = "How are you doing, %name%?" />
	<cfset variables.greetings[3] = "Nice to meet you, %name%." />
	<cfset variables.greetings[4] = "Hi %name%, have a nice day!" />
	<cfset variables.greetings[5] = "Hello %name%, what's new?" />

	<cffunction name="sayHello" hint="Says Hello to the user. It requires the user name" access="remote" output="false" returntype="Message">
		<cfargument name="name" type="String" hint="User name" required="true" />
			
			<!--- randomly select a greeting --->
			<cfset var greetingNumber =  randrange(1,arraylen(variables.greetings))>
			<!--- get the greeting from the array of options --->
			<cfset var greeting = variables.greetings[greetingNumber] />
			
			<!--- create a message object to return --->
			<cfset var messageVO = createObject("component","Message") />
			
			<!--- let's see if the client wants to see a Fault :) --->
			<cfif name EQ "bomb">
				<cfthrow message="I am sorry, but I don't like that name :(">
			</cfif>
			
			<!--- Replace %name% by the user's name --->
			<cfset greeting = replace(greeting,'%name%',arguments.name)  />
			
			<cfset messageVO.setText(greeting) /><!--- we could also use messageVO.text = greeting --->
			
			<cfreturn messageVO />
			
	</cffunction>
</cfcomponent>
