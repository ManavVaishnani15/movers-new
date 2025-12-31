<!--- Handler for sending Move Job Agreement to DocuSign --->
<cfif IsDefined("form.SendToDocuSign") AND IsDefined("url.formID")>
    <!--- Get carrier and form data --->
    <cfquery name="getCarrier" datasource="aaalh3x_onestep">
        SELECT RepFirstName, RepLastName, emailaddress, 
               Rep2FirstName, Rep2LastName, Rep2Emailaddress,
               Rep3FirstName, Rep3LastName, Rep3Emailaddress,
               AddToMoveJobAgreement, AddToMoveJobAgreement2, AddToMoveJobAgreement3
        FROM carrier_records
        WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ClientID#">
    </cfquery>
    
    <!--- Determine which representative to use --->
    <cfif getCarrier.AddToMoveJobAgreement EQ 1>
        <cfset signerName = Trim(getCarrier.RepFirstName & " " & getCarrier.RepLastName)>
        <cfset signerEmail = Trim(getCarrier.emailaddress)>
    <cfelseif getCarrier.AddToMoveJobAgreement2 EQ 1>
        <cfset signerName = Trim(getCarrier.Rep2FirstName & " " & getCarrier.Rep2LastName)>
        <cfset signerEmail = Trim(getCarrier.Rep2Emailaddress)>
    <cfelseif getCarrier.AddToMoveJobAgreement3 EQ 1>
        <cfset signerName = Trim(getCarrier.Rep3FirstName & " " & getCarrier.Rep3LastName)>
        <cfset signerEmail = Trim(getCarrier.Rep3Emailaddress)>
    <cfelse>
        <!--- Default to first representative --->
        <cfset signerName = Trim(getCarrier.RepFirstName & " " & getCarrier.RepLastName)>
        <cfset signerEmail = Trim(getCarrier.emailaddress)>
    </cfif>
    
    <!--- Validate email --->
    <cfif NOT IsValid("email", signerEmail)>
        <cfset session.docusignError = "Invalid email address for carrier representative: #signerEmail#">
        <cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no">
    </cfif>
    
    <!--- Initialize DocuSign service --->
    <cfset docuSignService = CreateObject("component", "components.DocuSignService")>
    
    <!--- Create return URL for after signing --->
    <cfset returnUrl = "https://#CGI.SERVER_NAME#/admin/docusign_callback.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#&formID=#url.formID#">
    
    <!--- Send to DocuSign --->
    <cfset sendResult = docuSignService.sendForSignature(
        clientId = ClientID,
        formId = url.formID,
        signerEmail = signerEmail,
        signerName = signerName,
        returnUrl = returnUrl
    )>
    
    <cfif sendResult.success>
        <!--- Update form status --->
        <cfquery datasource="aaalh3x_onestep">
            UPDATE carrier_move_job_agreements
            SET docusign_status = 'sent',
                docusign_envelope_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#sendResult.envelopeId#">,
                docusign_sent_date = NOW()
            WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.formID#">
        </cfquery>
        
        <cfset session.docusignSuccess = "Move Job Agreement successfully sent to #signerName# (#signerEmail#) for signature via DocuSign.">
        
        <!--- If we have a signing URL (embedded signing), redirect there --->
        <cfif Len(sendResult.signingUrl)>
            <cflocation url="#sendResult.signingUrl#" addtoken="no">
        <cfelse>
            <cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no">
        </cfif>
    <cfelse>
        <cfset session.docusignError = "Error sending to DocuSign: #sendResult.error#">
        <cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no">
    </cfif>
</cfif>

<!--- Handler for checking DocuSign status --->
<cfif IsDefined("url.checkDocuSignStatus") AND IsDefined("url.envelopeId")>
    <cfset docuSignService = CreateObject("component", "components.DocuSignService")>
    <cfset statusResult = docuSignService.getEnvelopeStatus(url.envelopeId)>
    
    <cfif statusResult.success>
        <!--- Get formID from envelope_id --->
        <cfquery name="getFormInfo" datasource="aaalh3x_onestep">
            SELECT id as formID
            FROM carrier_move_job_agreements
            WHERE docusign_envelope_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.envelopeId#">
        </cfquery>
        
        <!--- Update database with current status --->
        <cfquery datasource="aaalh3x_onestep">
            UPDATE carrier_docusign_envelopes
            SET status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#statusResult.status#">,
                updated_at = NOW()
            WHERE envelope_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#url.envelopeId#">
        </cfquery>
        
        <!--- If completed, download the signed document --->
        <cfif statusResult.status EQ "completed" AND getFormInfo.recordCount GT 0>
            <cfset savePath = ExpandPath("./CarrierDocuments/signed_move_job_agreement_#ClientID#_#getFormInfo.formID#.pdf")>
            <cfset downloadResult = docuSignService.downloadSignedDocument(url.envelopeId, savePath)>
            
            <cfif downloadResult.success>
                <cfquery datasource="aaalh3x_onestep">
                    UPDATE carrier_move_job_agreements
                    SET docusign_status = 'completed',
                        docusign_completed_date = NOW(),
                        signed_document_path = <cfqueryparam cfsqltype="cf_sql_varchar" value="#savePath#">
                    WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#getFormInfo.formID#">
                </cfquery>
                
                <cfset session.docusignSuccess = "Document has been signed and downloaded successfully!">
            </cfif>
        <cfelseif statusResult.status EQ "completed">
            <cfset session.docusignInfo = "Document completed but form record not found.">
        </cfif>
        
        <cfif statusResult.status NEQ "completed">
            <cfset session.docusignInfo = "Current status: #statusResult.status#">
        </cfif>
    <cfelse>
        <cfset session.docusignError = "Error checking status: #statusResult.error#">
    </cfif>
    
    <cflocation url="carrier_client_info.cfm?un=#un#&pw=#pw#&ClientID=#ClientID#" addtoken="no">
</cfif>
