<!--- DocuSign Callback Handler --->
<!--- This file handles the return from DocuSign after signing --->

<cfparam name="url.un" default="">
<cfparam name="url.pw" default="">
<cfparam name="url.ClientID" default="0">
<cfparam name="url.formID" default="0">
<cfparam name="url.event" default="">

<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>DocuSign - Signing Complete</title>
    <link rel="stylesheet" href="foundation-6.2.4/css/foundation.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <div class="row" style="margin-top: 50px;">
        <div class="small-12 columns text-center">
            <h2>Processing your signature...</h2>
            <p>Please wait while we verify and save your signed document.</p>
            <div class="spinner">
                <i class="fa fa-spinner fa-spin fa-3x"></i>
            </div>
        </div>
    </div>

    <cfif url.event EQ "signing_complete">
        <!--- Signing was completed --->
        <cfset docuSignService = CreateObject("component", "components.DocuSignService")>
        
        <!--- Get envelope ID from database --->
        <cfquery name="getEnvelope" datasource="aaalh3x_onestep">
            SELECT envelope_id
            FROM carrier_docusign_envelopes
            WHERE carrier_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.ClientID#">
              AND form_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formID#">
            ORDER BY created_at DESC
            LIMIT 1
        </cfquery>
        
        <cfif getEnvelope.RecordCount>
            <!--- Check the envelope status --->
            <cfset statusResult = docuSignService.getEnvelopeStatus(getEnvelope.envelope_id)>
            
            <cfif statusResult.success AND statusResult.status EQ "completed">
                <!--- Download the signed document --->
                <cfset savePath = ExpandPath("./CarrierDocuments/signed_move_job_agreement_#url.ClientID#_#url.formID#_#DateFormat(Now(), 'yyyymmdd')#_#TimeFormat(Now(), 'HHmmss')#.pdf")>
                <cfset downloadResult = docuSignService.downloadSignedDocument(getEnvelope.envelope_id, savePath)>
                
                <cfif downloadResult.success>
                    <!--- Update the move job agreement record --->
                    <cfquery datasource="aaalh3x_onestep">
                        UPDATE carrier_move_job_agreements
                        SET docusign_status = 'completed',
                            docusign_completed_date = NOW(),
                            signed_document_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#savePath#">
                        WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formID#">
                    </cfquery>
                    
                    <!--- Update envelope record --->
                    <cfquery datasource="aaalh3x_onestep">
                        UPDATE carrier_docusign_envelopes
                        SET status = 'completed',
                            updated_at = NOW()
                        WHERE envelope_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getEnvelope.envelope_id#">
                    </cfquery>
                    
                    <cfset session.docusignSuccess = "Thank you! Your signature has been successfully recorded and the document has been saved.">
                <cfelse>
                    <cfset session.docusignError = "Document was signed but there was an error downloading it: #downloadResult.error#">
                </cfif>
            <cfelse>
                <cfset session.docusignInfo = "Document signing is in progress. Status: #statusResult.status#">
            </cfif>
        </cfif>
        
    <cfelseif url.event EQ "cancel">
        <!--- User cancelled the signing --->
        <cfset session.docusignInfo = "Document signing was cancelled.">
        
    <cfelseif url.event EQ "decline">
        <!--- User declined to sign --->
        <cfquery datasource="aaalh3x_onestep">
            UPDATE carrier_move_job_agreements
            SET docusign_status = 'declined'
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formID#">
        </cfquery>
        
        <cfset session.docusignError = "Document signing was declined.">
    </cfif>

    <!--- Redirect back to carrier page --->
    <script>
        window.location.href = 'carrier_client_info.cfm?un=<cfoutput>#url.un#</cfoutput>&pw=<cfoutput>#url.pw#</cfoutput>&ClientID=<cfoutput>#url.ClientID#</cfoutput>';
    </script>
</body>
</html>
