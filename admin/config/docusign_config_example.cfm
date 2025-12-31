<!---
    DocuSign Configuration Example
    Copy this to Application.cfc or create a separate config file
--->

<cfset application.docusign = {
    // Sandbox/Demo Configuration
    sandbox: {
        accountId: "12345678-abcd-1234-abcd-123456789abc",
        integrationKey: "a1b2c3d4-5678-90ab-cdef-1234567890ab",
        userId: "98765432-dcba-4321-dcba-0987654321ba",
        rsaPrivateKey: "-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA...your_private_key_here...
-----END RSA PRIVATE KEY-----",
        authServer: "https://account-d.docusign.com",
        apiBaseUrl: "https://demo.docusign.net/restapi",
        oAuthBasePath: "account-d.docusign.com"
    },
    
    // Production Configuration
    production: {
        accountId: "YOUR_PRODUCTION_ACCOUNT_ID",
        integrationKey: "YOUR_PRODUCTION_INTEGRATION_KEY",
        userId: "YOUR_PRODUCTION_USER_ID",
        rsaPrivateKey: "YOUR_PRODUCTION_RSA_PRIVATE_KEY",
        authServer: "https://account.docusign.com",
        apiBaseUrl: "https://na1.docusign.net/restapi",  // Region may vary
        oAuthBasePath: "account.docusign.com"
    },
    
    // Current environment
    currentEnv: "sandbox"  // Change to "production" when ready
}>

<!---
    HOW TO GET YOUR CREDENTIALS:
    
    1. Account ID:
       - Log in to DocuSign Admin
       - Go to Settings → API and Keys
       - Copy your Account ID
    
    2. Integration Key:
       - In DocuSign Admin, go to Apps and Keys
       - Click "Add App and Integration Key"
       - Give it a name and save
       - Copy the Integration Key (Client ID)
    
    3. User ID:
       - In DocuSign Admin, go to Users
       - Click on your user
       - Copy the API Username (GUID format)
    
    4. RSA Private Key:
       - Generate using OpenSSL:
         openssl genrsa -out private.key 2048
         openssl rsa -in private.key -pubout -out public.key
       - Upload public.key to your DocuSign App (Apps and Keys → Your App → Add RSA Keypair)
       - Copy content of private.key here
    
    5. API Base URL:
       - Sandbox: https://demo.docusign.net/restapi
       - Production: Check your region at Settings → API and Keys
         - North America (NA1): https://na1.docusign.net/restapi
         - NA2: https://na2.docusign.net/restapi
         - NA3: https://na3.docusign.net/restapi
         - EU: https://eu.docusign.net/restapi
         - AU: https://au.docusign.net/restapi
--->

<!---
    ALTERNATIVE: Use environment variables (recommended for production)
--->
<cfif IsDefined("server.system.environment.DOCUSIGN_ACCOUNT_ID")>
    <cfset application.docusign.production.accountId = server.system.environment.DOCUSIGN_ACCOUNT_ID>
    <cfset application.docusign.production.integrationKey = server.system.environment.DOCUSIGN_INTEGRATION_KEY>
    <cfset application.docusign.production.userId = server.system.environment.DOCUSIGN_USER_ID>
    <cfset application.docusign.production.rsaPrivateKey = server.system.environment.DOCUSIGN_PRIVATE_KEY>
</cfif>

<!---
    ALTERNATIVE: Read from encrypted config file
--->
<cffunction name="getDocuSignConfig" returntype="struct">
    <cfargument name="environment" type="string" default="sandbox">
    
    <cfif arguments.environment EQ "production" AND application.docusign.currentEnv EQ "production">
        <cfreturn application.docusign.production>
    <cfelse>
        <cfreturn application.docusign.sandbox>
    </cfif>
</cffunction>
