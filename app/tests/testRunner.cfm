<cfset VARIABLES.mxTest = createObject( "component", "mxunit.framework.TestSuite" ).TestSuite() />
<cfset VARIABLES.mxTest.addAll("globalChallenge.app.tests.testServerModel") />
<cfset VARIABLES.results = VARIABLES.mxTest.run() />
<cfoutput>
    #VARIABLES.results.getHtmlResults( "../mxunit/" )#
</cfoutput>