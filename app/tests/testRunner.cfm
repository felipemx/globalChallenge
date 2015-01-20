<cfset VARIABLES.mxTest = createObject("component", "mxunit.framework.TestSuite").TestSuite() />
<cfset VARIABLES.mxTest.addAll("globalChallenge.app.tests.testServerModel") />
<cfset VARIABLES.mxTest.addAll("globalChallenge.app.tests.testAppModel") />
<cfset VARIABLES.mxTest.addAll("globalChallenge.app.tests.testServerController") />
<cfset VARIABLES.mxTest.addAll("globalChallenge.app.tests.testAppController") />
<cfset VARIABLES.results = VARIABLES.mxTest.run() />
<cfoutput>
    #VARIABLES.results.getHTMLResults("../../../mxunit")#
</cfoutput>