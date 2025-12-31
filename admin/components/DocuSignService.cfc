<cfcomponent displayname="DocuSignService" hint="Handles DocuSign API integration for document signing">

    <!--- DocuSign Configuration --->
    <cfset variables.docusignConfig = {
        accountId = "f47ac958-9923-492b-acf3-6a147e72b83b",
        integrationKey = "4c1e9d51-c2a3-45e6-ab13-d7af88981c63",
        userId = "f85159c1-bb3a-4659-bc00-6a4731b22567",
        rsaPrivateKey = "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAnvUshtSzabCOY3wdOHD4ykvbDBXyOO7q++xvZkE0yy8cZIow
PwmyF9YVHNLTssvzmtGWdBhrGI3sx/iOf3pka7OMJRUDFbklUo61vMUEYD47Ju7N
8/5QFeDP8f/TZX9+oRLMcGHZ/zn/XQr+5nSvxi7/gFfjgPkh5hvRWZyeW8xd9MYg
P+PJZk8rzQc7O+y+5wJ1N1HWRNYJ0NfD+Rb6EGIBw/UTIkIRQnhJWDfJzd3GcahJ
8sRql0N3fYOuNJjzNUioHN4bTaW+s2L6txaGfEGv5IlS5URMUu5lYHHm5kd68jmJ
FCvoTm8BT6JGJHwxIOoiTGF2XAifESFudCcNSwIDAQABAoIBADRZS+uvetKQuaPb
yQfAdL6ykpX9WEMVs795kwpa6RcNEc2ukMsB12vwLg3LBLr6XeSbp2/eZs60VslY
ex1SYmXxwHKp49UwnzD8HK/pNlK3y+U7egojs54w5mqtNKJVhY9oUHmmUBO0tvue
Vmnw/b5H1g8fYqYj5d0RRjW71Y8nSzuuCL3Cl6EJ1Zfk+vD9r8u87hi0owgfMrTR
hAF7HL4HLDaUxQU7nJC89UgeccA4k/J2yc/wpGQG5qnIQ+1OUZRpVyM4uPsXYqR4
wv15dEIutujdnV4pOOrppKmLu30geUOQL5m8ByR8oJDxQhPDLIBDuFDRB7ohefl8
dPcInyECgYEA/svpjFmZxea65mK6er+hRr4PbrvIZ4RB92nOQDlAJSFSPGEwYOPz
kIcIFxdkNCBakjUWLrui3ZLYBNpfv13r8JmH+uWy//k863HMGXsjdBIzZjFvB/KQ
xQkzsTZNKMUhOFwUZIXH+B6Be/ccGXFdCsO6nBysjgOft4rPHQ1o8DsCgYEAn7Vg
wPl5/9l4OUvbcaUBviXVRH9GunoYtKnQId7zHjjyKaO1Y2DZzZOgO98qLEJwC9Y/
Ve5zwb6BpM1Ox23O4xiv/kexU1coLEzCAGoYmpjNEvEGFBrF8q12oCcOEE4y3Sk6
9ycMW0+06CSJ4w2nt2jFem/6dITZ6qH9FACEFjECgYEAlOxYQDkqoLogKYIxHoec
2v1BheZp1t89sz97VpxfupQEPdhMb4Usmh/igaShY7o5VdWDdqMjKUCn1AZTCkX6
HnGOQf45plVl3vNvaMFJUpFEy4k/LTUAmrmrJfvoE1lM9mUTYkGzRHmIEw22tcRF
roICMzarQIIruxp9vaxV1nsCgYEAlIzCp/vkrEN8/d4/CR+v1UufaQzxnrW+kRx6
SWb0v6G8LVrmdr85F2w+2DGlKnHJglkPpEAdT5KBR+bnZbwPeVAXMu9AUwJ4jWv/
7x7AL9v8s6eYPc8BW85YznJFNIln6ipVfFnHto8W9+40iwrCe2hqdo39aa/Aeeue
WKJ6OaECgYEAmTCGDWgY98tx3aMloRlJltmENu/9Tlm6IkRRLP15Yc0iM8lH5MO3
T8iODYV0J3KPXCNfvkNkI2U5OGKjZh8ZONq0fuu/nR5JHC73Ew6qDT5uJtjKQXVi
vocm4cuX6FN3XvZWEB3VNNnw4brgFW7gvDKptf6IWP3EK//vk8OYEgs=
-----END RSA PRIVATE KEY-----",
        authServer = "https://account-d.docusign.com",
        apiBaseUrl = "https://demo.docusign.net/restapi",
        oAuthBasePath = "account-d.docusign.com"
    }>

    <!--- Get JWT Access Token --->
    <cffunction name="getJWTToken" access="public" returntype="struct" hint="Get JWT access token for DocuSign API">
        <cfset var result = {success: false, token: "", error: ""}>
        
        <cftry>
            <!--- Create JWT token --->
            <cfset var jwtToken = createSignedJWT()>
            
            <cfif NOT Len(jwtToken)>
                <cfset result.error = "Failed to create JWT token">
                <cfreturn result>
            </cfif>
            
            <!--- Request access token --->
            <cfhttp url="#variables.docusignConfig.authServer#/oauth/token" 
                    method="POST" 
                    result="httpResult"
                    timeout="30">
                <cfhttpparam type="formfield" name="grant_type" value="urn:ietf:params:oauth:grant-type:jwt-bearer">
                <cfhttpparam type="formfield" name="assertion" value="#jwtToken#">
            </cfhttp>
            
            <cfif httpResult.statusCode CONTAINS "200">
                <cfset var tokenData = DeserializeJSON(httpResult.fileContent)>
                <cfset result.success = true>
                <cfset result.token = tokenData.access_token>
            <cfelse>
                <cfset result.error = "Failed to get access token: " & httpResult.statusCode & " - " & httpResult.fileContent>
            </cfif>
            
            <cfcatch>
                <cfset result.error = "Error getting JWT token: " & cfcatch.message & " - " & cfcatch.detail>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

    <!--- Create Signed JWT Token using simpler approach --->
    <cffunction name="createSignedJWT" access="private" returntype="string" hint="Create and sign JWT token with RSA">
        <cftry>
            <!--- Try using external JWT service if Java signing fails --->
            <cfset var useExternalJWT = true>
            
            <cfif useExternalJWT>
                <cfreturn createJWTviaScript()>
            </cfif>
            <!--- JWT Header --->
            <cfset var header = {
                "alg": "RS256",
                "typ": "JWT"
            }>
            
            <!--- JWT Payload --->
            <cfset var currentTime = DateDiff("s", CreateDateTime(1970,1,1,0,0,0), Now())>
            <cfset var payload = {
                "iss": variables.docusignConfig.integrationKey,
                "sub": variables.docusignConfig.userId,
                "aud": variables.docusignConfig.oAuthBasePath,
                "iat": currentTime,
                "exp": currentTime + 3600,
                "scope": "signature impersonation"
            }>
            
            <!--- Base64URL encode header and payload --->
            <cfset var headerJson = SerializeJSON(header)>
            <cfset var payloadJson = SerializeJSON(payload)>
            
            <cfset var headerBase64 = base64UrlEncode(headerJson)>
            <cfset var payloadBase64 = base64UrlEncode(payloadJson)>
            
            <!--- Create signing input --->
            <cfset var signingInput = headerBase64 & "." & payloadBase64>
            
            <!--- Sign with RSA private key --->
            <cfset var signature = signWithRSA(signingInput)>
            
            <!--- Return complete JWT --->
            <cfif Len(signature)>
                <cfreturn signingInput & "." & signature>
            <cfelse>
                <cflog file="docusign" text="Error: Empty signature returned">
                <cfreturn "">
            </cfif>
            
            <cfcatch>
                <cflog file="docusign" text="Error creating JWT: #cfcatch.message# - #cfcatch.detail# - #cfcatch.stackTrace#">
                <cfreturn "">
            </cfcatch>
        </cftry>
    </cffunction>
    
    <!--- Base64 URL Encode --->
    <cffunction name="base64UrlEncode" access="private" returntype="string">
        <cfargument name="input" type="string" required="true">
        
        <cfset var base64 = ToBase64(arguments.input)>
        <!--- Convert standard Base64 to Base64URL --->
        <cfset base64 = Replace(base64, "+", "-", "all")>
        <cfset base64 = Replace(base64, "/", "_", "all")>
        <cfset base64 = Replace(base64, "=", "", "all")>
        
        <cfreturn base64>
    </cffunction>
    
    <!--- Sign with RSA Private Key --->
    <cffunction name="signWithRSA" access="private" returntype="string">
        <cfargument name="data" type="string" required="true">
        
        <cftry>
            <cflog file="docusign" text="Starting RSA signing process...">
            
            <!--- Import Java classes --->
            <cfset var KeyFactory = CreateObject("java", "java.security.KeyFactory")>
            <cfset var PKCS8EncodedKeySpec = CreateObject("java", "java.security.spec.PKCS8EncodedKeySpec")>
            <cfset var Signature = CreateObject("java", "java.security.Signature")>
            <cfset var Base64 = CreateObject("java", "java.util.Base64")>
            
            <cflog file="docusign" text="Java classes loaded successfully">
            
            <!--- Clean private key --->
            <cfset var privateKeyPEM = variables.docusignConfig.rsaPrivateKey>
            <cflog file="docusign" text="Original key length: #Len(privateKeyPEM)#">
            
            <cfset privateKeyPEM = Replace(privateKeyPEM, "-----BEGIN RSA PRIVATE KEY-----", "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, "-----END RSA PRIVATE KEY-----", "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, "-----BEGIN PRIVATE KEY-----", "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, "-----END PRIVATE KEY-----", "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, Chr(13), "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, Chr(10), "", "all")>
            <cfset privateKeyPEM = Replace(privateKeyPEM, " ", "", "all")>
            <cfset privateKeyPEM = Trim(privateKeyPEM)>
            
            <cflog file="docusign" text="Cleaned key length: #Len(privateKeyPEM)#">
            
            <!--- Decode private key --->
            <cfset var decoder = Base64.getDecoder()>
            <cfset var keyBytes = decoder.decode(privateKeyPEM)>
            
            <cflog file="docusign" text="Key decoded, byte array length: #ArrayLen(keyBytes)#">
            
            <!--- Try to create private key object --->
            <cfset var privateKey = "">
            <cfset var conversionAttempt = "none">
            
            <cftry>
                <!--- First try as PKCS#8 format --->
                <cflog file="docusign" text="Attempting PKCS##8 format...">
                <cfset var keySpec = PKCS8EncodedKeySpec.init(keyBytes)>
                <cfset var keyFactory = KeyFactory.getInstance("RSA")>
                <cfset privateKey = keyFactory.generatePrivate(keySpec)>
                <cfset conversionAttempt = "PKCS##8 direct">
                <cflog file="docusign" text="PKCS##8 direct successful">
                
                <cfcatch>
                    <cflog file="docusign" text="PKCS##8 failed: #cfcatch.message#, trying PKCS##1 conversion...">
                    <!--- If PKCS#8 fails, convert from PKCS#1 --->
                    <cfset keyBytes = convertPKCS1toPKCS8Simple(keyBytes)>
                    <cfset keySpec = PKCS8EncodedKeySpec.init(keyBytes)>
                    <cfset keyFactory = KeyFactory.getInstance("RSA")>
                    <cfset privateKey = keyFactory.generatePrivate(keySpec)>
                    <cfset conversionAttempt = "PKCS##1 to PKCS##8 conversion">
                    <cflog file="docusign" text="PKCS##1 conversion successful">
                </cfcatch>
            </cftry>
            
            <cfif NOT IsObject(privateKey)>
                <cflog file="docusign" text="ERROR: Failed to create private key object">
                <cfreturn "">
            </cfif>
            
            <cflog file="docusign" text="Private key created using: #conversionAttempt#">
            
            <!--- Sign data --->
            <cflog file="docusign" text="Starting signature process...">
            <cfset var signer = Signature.getInstance("SHA256withRSA")>
            <cfset signer.initSign(privateKey)>
            <cfset signer.update(arguments.data.getBytes("UTF-8"))>
            <cfset var signatureBytes = signer.sign()>
            
            <cflog file="docusign" text="Signature created, length: #ArrayLen(signatureBytes)#">
            
            <!--- Base64URL encode signature --->
            <cfset var signatureBase64 = ToBase64(signatureBytes)>
            <cfset signatureBase64 = Replace(signatureBase64, "+", "-", "all")>
            <cfset signatureBase64 = Replace(signatureBase64, "/", "_", "all")>
            <cfset signatureBase64 = Replace(signatureBase64, "=", "", "all")>
            
            <cflog file="docusign" text="Signature Base64URL encoded, length: #Len(signatureBase64)#">
            
            <cfreturn signatureBase64>
            
            <cfcatch>
                <cflog file="docusign" text="FATAL ERROR in signWithRSA: #cfcatch.message# - #cfcatch.detail# - Type: #cfcatch.type# - StackTrace: #cfcatch.stackTrace#">
                <cfreturn "">
            </cfcatch>
        </cftry>
    </cffunction>
    
    <!--- Create JWT using Python script as fallback --->
    <cffunction name="createJWTviaScript" access="private" returntype="string" hint="Create JWT using external Python script">
        <cftry>
            <!--- Create temporary Python script --->
            <cfset var scriptPath = ExpandPath("./temp/create_jwt.py")>
            <cfset var keyPath = ExpandPath("./temp/private_key.pem")>
            
            <!--- Save private key to temp file --->
            <cffile action="write" file="#keyPath#" output="#variables.docusignConfig.rsaPrivateKey#">
            
            <!--- Create Python script --->
            <cfset var pythonScript = '
import jwt
import time
import sys

<!--- JWT claims --->
claims = {
    "iss": "' & variables.docusignConfig.integrationKey & '",
    "sub": "' & variables.docusignConfig.userId & '",
    "aud": "' & variables.docusignConfig.oAuthBasePath & '",
    "iat": int(time.time()),
    "exp": int(time.time()) + 3600,
    "scope": "signature impersonation"
}

<!---  Read private key --->
with open("' & Replace(keyPath, "\", "\\", "ALL") & '", "r") as key_file:
    private_key = key_file.read()

<!--- Create JWT --->
token = jwt.encode(claims, private_key, algorithm="RS256")
print(token)
'>
            
            <cffile action="write" file="#scriptPath#" output="#pythonScript#">
            
            <!--- Execute Python script using venv Python --->
            <cfset var pythonExe = "C:/lucee/tomcat/webapps/ROOT/movers/.venv/Scripts/python.exe">
            <cfexecute name="#pythonExe#" 
                      arguments="#scriptPath#" 
                      variable="jwtToken" 
                      timeout="10">
            </cfexecute>
            
            <!--- Clean up temp files --->
            <cffile action="delete" file="#scriptPath#">
            <cffile action="delete" file="#keyPath#">
            
            <cfreturn Trim(jwtToken)>
            
            <cfcatch>
                <!--- If Python approach fails, try Node.js --->
                <cfreturn createJWTviaNodeJS()>
            </cfcatch>
        </cftry>
    </cffunction>
    
    <!--- Create JWT using Node.js script as alternative fallback --->
    <cffunction name="createJWTviaNodeJS" access="private" returntype="string" hint="Create JWT using external Node.js script">
        <cftry>
            <!--- Create temporary Node.js script --->
            <cfset var scriptPath = ExpandPath("./temp/create_jwt.js")>
            <cfset var keyPath = ExpandPath("./temp/private_key.pem")>
            
            <!--- Save private key to temp file --->
            <cffile action="write" file="#keyPath#" output="#variables.docusignConfig.rsaPrivateKey#">
            
            <!--- Create Node.js script --->
            <cfset var nodeScript = '
const fs = require("fs");
const crypto = require("crypto");

const claims = {
    iss: "' & variables.docusignConfig.integrationKey & '",
    sub: "' & variables.docusignConfig.userId & '",
    aud: "' & variables.docusignConfig.oAuthBasePath & '",
    iat: Math.floor(Date.now() / 1000),
    exp: Math.floor(Date.now() / 1000) + 3600,
    scope: "signature impersonation"
};

const header = { alg: "RS256", typ: "JWT" };

const base64url = (str) => {
    return Buffer.from(str).toString("base64")
        .replace(/=/g, "")
        .replace(/\+/g, "-")
        .replace(/\//g, "_");
};

const headerEncoded = base64url(JSON.stringify(header));
const payloadEncoded = base64url(JSON.stringify(claims));
const signingInput = headerEncoded + "." + payloadEncoded;

const privateKey = fs.readFileSync("' & Replace(keyPath, "\", "\\", "ALL") & '", "utf8");
const signature = crypto.createSign("RSA-SHA256").update(signingInput).sign(privateKey, "base64");
const signatureEncoded = signature.replace(/=/g, "").replace(/\+/g, "-").replace(/\//g, "_");

console.log(signingInput + "." + signatureEncoded);
'>
            
            <cffile action="write" file="#scriptPath#" output="#nodeScript#">
            
            <!--- Execute Node.js script --->
            <cfexecute name="node" 
                      arguments="#scriptPath#" 
                      variable="jwtToken" 
                      timeout="10">
            </cfexecute>
            
            <!--- Clean up temp files --->
            <cffile action="delete" file="#scriptPath#">
            <cffile action="delete" file="#keyPath#">
            
            <cfreturn Trim(jwtToken)>
            
            <cfcatch>
                <!--- Both external methods failed, return empty --->
                <cfthrow message="Failed to create JWT token using Python or Node.js. Error: #cfcatch.message#">
            </cfcatch>
        </cftry>
    </cffunction>

    <!--- Simple PKCS#1 to PKCS#8 conversion --->
    <cffunction name="convertPKCS1toPKCS8Simple" access="private" returntype="any">
        <cfargument name="pkcs1Bytes" type="any" required="true">
        
        <cftry>
            <!--- Create PKCS#8 header for RSA private key (using decimal notation) --->
            <cfset var header = [
                48, 130, 4, 189, 2, 1, 0, 48, 
                13, 6, 9, 42, 134, 72, 134, 247, 
                13, 1, 1, 1, 5, 0, 4, 130, 
                4, 167
            ]>
            
            <!--- Create byte array output stream --->
            <cfset var ByteArrayOutputStream = CreateObject("java", "java.io.ByteArrayOutputStream")>
            <cfset var baos = ByteArrayOutputStream.init()>
            
            <!--- Write header bytes --->
            <cfloop array="#header#" index="b">
                <cfset baos.write(javaCast("int", b))>
            </cfloop>
            
            <!--- Write original key bytes --->
            <cfset baos.write(arguments.pkcs1Bytes)>
            
            <cfreturn baos.toByteArray()>
            
            <cfcatch>
                <cflog file="docusign" text="Error converting PKCS1 to PKCS8: #cfcatch.message#">
                <!--- Return original bytes if conversion fails --->
                <cfreturn arguments.pkcs1Bytes>
            </cfcatch>
        </cftry>
    </cffunction>

    <!--- Generate PDF from CFML template --->
    <cffunction name="generatePDF" access="public" returntype="struct" hint="Generate PDF from move_job_agreement.cfm">
        <cfargument name="clientId" type="numeric" required="true">
        <cfargument name="formId" type="numeric" required="true">
        
        <cfset var result = {success: false, pdfPath: "", error: ""}>
        
        <cftry>
            <!--- Generate unique filename --->
            <cfset var fileName = "move_job_agreement_#arguments.clientId#_#arguments.formId#_#CreateUUID()#.pdf">
            <cfset var pdfPath = ExpandPath("./temp/#fileName#")>
            
            <!--- Create temp directory if it doesn't exist --->
            <cfif NOT DirectoryExists(ExpandPath("./temp"))>
                <cfdirectory action="create" directory="#ExpandPath('./temp')#">
            </cfif>
            
            <!--- Generate PDF using cfdocument --->
            <cfsavecontent variable="pdfContent">
                <cfinclude template="../letters/move_job_agreement.cfm">
            </cfsavecontent>
            
            <cfdocument format="pdf" 
                        filename="#pdfPath#" 
                        overwrite="yes"
                        orientation="portrait"
                        pageType="letter"
                        margintop="0"
                        marginbottom="0"
                        marginleft="0"
                        marginright="0">
                <cfoutput>#pdfContent#</cfoutput>
            </cfdocument>
            
            <cfset result.success = true>
            <cfset result.pdfPath = pdfPath>
            <cfset result.fileName = fileName>
            
            <cfcatch>
                <cfset result.error = "Error generating PDF: " & cfcatch.message>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

    <!--- Create and Send Envelope to DocuSign --->
    <cffunction name="sendForSignature" access="public" returntype="struct" hint="Send document to DocuSign for signature">
        <cfargument name="clientId" type="numeric" required="true">
        <cfargument name="formId" type="numeric" required="true">
        <cfargument name="signerEmail" type="string" required="true">
        <cfargument name="signerName" type="string" required="true">
        <cfargument name="returnUrl" type="string" required="false" default="">
        
        <cfset var result = {success: false, envelopeId: "", signingUrl: "", error: ""}>
        
        <cftry>
            <!--- Get access token --->
            <cfset var tokenResult = getJWTToken()>
            <cfif NOT tokenResult.success>
                <cfset result.error = tokenResult.error>
                <cfreturn result>
            </cfif>
            
            <!--- Get existing PDF path from database --->
            <cfquery name="getPDFPath" datasource="aaalh3x_onestep">
                SELECT pdf_path
                FROM carrier_move_job_agreements
                WHERE id = <cfqueryparam value="#arguments.formId#" cfsqltype="cf_sql_integer">
            </cfquery>
            
            <!--- Build full path to existing PDF --->
            <cfif getPDFPath.recordCount GT 0 AND getPDFPath.pdf_path NEQ "" AND NOT IsNull(getPDFPath.pdf_path)>
                <cfset var pdfPath = ExpandPath("./CarrierDocuments/#getPDFPath.pdf_path#")>
                <cfset var fileName = getPDFPath.pdf_path>
                
                <!--- Verify PDF file exists --->
                <cfif NOT FileExists(pdfPath)>
                    <cfset result.error = "PDF file not found: #fileName#">
                    <cflog file="docusign" text="PDF file not found: #pdfPath#">
                    <cfreturn result>
                </cfif>
                
                <cflog file="docusign" text="Using existing PDF: #pdfPath#">
            <cfelse>
                <!--- No PDF exists, generate one --->
                <cflog file="docusign" text="No PDF found in database, generating new PDF">
                <cfset var pdfResult = generatePDF(arguments.clientId, arguments.formId)>
                <cfif NOT pdfResult.success>
                    <cfset result.error = pdfResult.error>
                    <cfreturn result>
                </cfif>
                <cfset pdfPath = pdfResult.pdfPath>
                <cfset fileName = pdfResult.fileName>
            </cfif>
            
            <!--- Read PDF as Base64 --->
            <cffile action="readBinary" file="#pdfPath#" variable="pdfBinary">
            <cfset var pdfBase64 = ToBase64(pdfBinary)>
            
            <!--- Create envelope definition --->
            <cfset var envelopeDefinition = {
                "emailSubject": "Please sign: Move Job Acceptance Agreement",
                "documents": [
                    {
                        "documentBase64": pdfBase64,
                        "name": fileName,
                        "fileExtension": "pdf",
                        "documentId": "1"
                    }
                ],
                "recipients": {
                    "signers": [
                        {
                            "email": arguments.signerEmail,
                            "name": arguments.signerName,
                            "recipientId": "1",
                            "routingOrder": "1",
                            "tabs": {
                                "signHereTabs": [
                                    {
                                        "documentId": "1",
                                        "pageNumber": "7",
                                        "xPosition": "100",
                                        "yPosition": "350"
                                    }
                                ],
                                "initialHereTabs": [
                                    {"documentId": "1", "pageNumber": "1", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "2", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "3", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "4", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "5", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "6", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "7", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "8", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "9", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "10", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "11", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "12", "xPosition": "500", "yPosition": "700"},
                                    {"documentId": "1", "pageNumber": "13", "xPosition": "500", "yPosition": "700"}
                                ],
                                "dateSignedTabs": [
                                    {"documentId": "1", "pageNumber": "7", "xPosition": "300", "yPosition": "350"}
                                ]
                            }
                        }
                    ]
                },
                "status": "sent"
            }>
            
            <!--- Send to DocuSign --->
            <cfhttp url="#variables.docusignConfig.apiBaseUrl#/v2.1/accounts/#variables.docusignConfig.accountId#/envelopes" 
                    method="POST" 
                    result="httpResult">
                <cfhttpparam type="header" name="Authorization" value="Bearer #tokenResult.token#">
                <cfhttpparam type="header" name="Content-Type" value="application/json">
                <cfhttpparam type="body" value="#SerializeJSON(envelopeDefinition)#">
            </cfhttp>
            
            <cfif httpResult.statusCode CONTAINS "201">
                <cfset var envelopeData = DeserializeJSON(httpResult.fileContent)>
                <cfset result.success = true>
                <cfset result.envelopeId = envelopeData.envelopeId>
                
                <!--- Get recipient view (signing URL) for embedded signing --->
                <cfif Len(arguments.returnUrl)>
                    <cfset var recipientView = getRecipientView(
                        tokenResult.token,
                        envelopeData.envelopeId,
                        arguments.signerEmail,
                        arguments.signerName,
                        arguments.returnUrl
                    )>
                    <cfif recipientView.success>
                        <cfset result.signingUrl = recipientView.url>
                    </cfif>
                </cfif>
                
                <!--- Log to database --->
                <cfquery datasource="aaalh3x_onestep">
                    INSERT INTO carrier_docusign_envelopes (
                        carrier_id,
                        form_id,
                        envelope_id,
                        signer_email,
                        signer_name,
                        status,
                        created_at
                    ) VALUES (
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientId#">,
                        <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.formId#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#result.envelopeId#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.signerEmail#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.signerName#">,
                        'sent',
                        NOW()
                    )
                </cfquery>
            <cfelse>
                <cfset result.error = "DocuSign API error: " & httpResult.statusCode & " - " & httpResult.fileContent>
            </cfif>
            
            <!--- Clean up temporary PDF --->
            <cfif FileExists(pdfResult.pdfPath)>
                <cffile action="delete" file="#pdfResult.pdfPath#">
            </cfif>
            
            <cfcatch>
                <cfset result.error = "Error sending to DocuSign: " & cfcatch.message>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

    <!--- Get Recipient View for Embedded Signing --->
    <cffunction name="getRecipientView" access="private" returntype="struct">
        <cfargument name="accessToken" type="string" required="true">
        <cfargument name="envelopeId" type="string" required="true">
        <cfargument name="signerEmail" type="string" required="true">
        <cfargument name="signerName" type="string" required="true">
        <cfargument name="returnUrl" type="string" required="true">
        
        <cfset var result = {success: false, url: "", error: ""}>
        
        <cftry>
            <cfset var viewRequest = {
                "returnUrl": arguments.returnUrl,
                "authenticationMethod": "none",
                "email": arguments.signerEmail,
                "userName": arguments.signerName,
                "clientUserId": arguments.signerEmail
            }>
            
            <cfhttp url="#variables.docusignConfig.apiBaseUrl#/v2.1/accounts/#variables.docusignConfig.accountId#/envelopes/#arguments.envelopeId#/views/recipient" 
                    method="POST" 
                    result="httpResult">
                <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accessToken#">
                <cfhttpparam type="header" name="Content-Type" value="application/json">
                <cfhttpparam type="body" value="#SerializeJSON(viewRequest)#">
            </cfhttp>
            
            <cfif httpResult.statusCode CONTAINS "201">
                <cfset var viewData = DeserializeJSON(httpResult.fileContent)>
                <cfset result.success = true>
                <cfset result.url = viewData.url>
            <cfelse>
                <cfset result.error = "Error getting recipient view: " & httpResult.statusCode>
            </cfif>
            
            <cfcatch>
                <cfset result.error = "Error in getRecipientView: " & cfcatch.message>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

    <!--- Check Envelope Status --->
    <cffunction name="getEnvelopeStatus" access="public" returntype="struct">
        <cfargument name="envelopeId" type="string" required="true">
        
        <cfset var result = {success: false, status: "", error: ""}>
        
        <cftry>
            <cfset var tokenResult = getJWTToken()>
            <cfif NOT tokenResult.success>
                <cfset result.error = tokenResult.error>
                <cfreturn result>
            </cfif>
            
            <cfhttp url="#variables.docusignConfig.apiBaseUrl#/v2.1/accounts/#variables.docusignConfig.accountId#/envelopes/#arguments.envelopeId#" 
                    method="GET" 
                    result="httpResult">
                <cfhttpparam type="header" name="Authorization" value="Bearer #tokenResult.token#">
            </cfhttp>
            
            <cfif httpResult.statusCode EQ "200 OK">
                <cfset var envelopeData = DeserializeJSON(httpResult.fileContent)>
                <cfset result.success = true>
                <cfset result.status = envelopeData.status>
                <cfset result.data = envelopeData>
            <cfelse>
                <cfset result.error = "Error getting envelope status: " & httpResult.statusCode>
            </cfif>
            
            <cfcatch>
                <cfset result.error = "Error in getEnvelopeStatus: " & cfcatch.message>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

    <!--- Download Signed Document --->
    <cffunction name="downloadSignedDocument" access="public" returntype="struct">
        <cfargument name="envelopeId" type="string" required="true">
        <cfargument name="savePath" type="string" required="true">
        
        <cfset var result = {success: false, filePath: "", error: ""}>
        
        <cftry>
            <cfset var tokenResult = getJWTToken()>
            <cfif NOT tokenResult.success>
                <cfset result.error = tokenResult.error>
                <cfreturn result>
            </cfif>
            
            <cfhttp url="#variables.docusignConfig.apiBaseUrl#/v2.1/accounts/#variables.docusignConfig.accountId#/envelopes/#arguments.envelopeId#/documents/combined" 
                    method="GET" 
                    result="httpResult"
                    getAsBinary="yes"
                    path="#GetDirectoryFromPath(arguments.savePath)#"
                    file="#GetFileFromPath(arguments.savePath)#">
                <cfhttpparam type="header" name="Authorization" value="Bearer #tokenResult.token#">
            </cfhttp>
            
            <cfif httpResult.statusCode EQ "200 OK">
                <cfset result.success = true>
                <cfset result.filePath = arguments.savePath>
            <cfelse>
                <cfset result.error = "Error downloading document: " & httpResult.statusCode>
            </cfif>
            
            <cfcatch>
                <cfset result.error = "Error in downloadSignedDocument: " & cfcatch.message>
            </cfcatch>
        </cftry>
        
        <cfreturn result>
    </cffunction>

</cfcomponent>
