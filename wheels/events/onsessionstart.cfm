<cffunction name="onSessionStart" returntype="void" access="public" output="false">
	<cfscript>
		//fix for shared application name issue 359
		if(!StructKeyExists(application, "wheels") || !StructKeyExists(application.wheels, "eventpath"))
		{
			$simpleLock(name="reloadLock#application.applicationName#", execute="onApplicationStart", type="exclusive", timeout=180);
		}

		$simpleLock(name="reloadLock#application.applicationName#", execute="$runOnSessionStart", type="readOnly", timeout=180);
	</cfscript>
</cffunction>

<cffunction name="$runOnSessionStart" returntype="void" access="public" output="false">
	<cfscript>
		$initializeRequestScope();
		$include(template="#application.wheels.eventPath#/onsessionstart.cfm");
	</cfscript>
</cffunction>