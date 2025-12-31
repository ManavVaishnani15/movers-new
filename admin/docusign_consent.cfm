<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DocuSign - Grant Consent</title>
    <link rel="stylesheet" href="foundation-6.2.4/css/foundation.css">
    <link rel="stylesheet" href="font-awesome-4.7.0/css/font-awesome.css">
    <style>
        .consent-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
        }
        .step {
            background: #f9f9f9;
            border-left: 4px solid #3adb76;
            padding: 20px;
            margin: 20px 0;
        }
        .step h3 {
            color: #3adb76;
            margin-top: 0;
        }
        .code-box {
            background: #f4f4f4;
            border: 1px solid #ddd;
            padding: 15px;
            font-family: monospace;
            word-break: break-all;
            margin: 10px 0;
        }
        .success-box {
            background: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .warning-box {
            background: #fff3cd;
            border: 1px solid #ffc107;
            color: #856404;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="consent-container">
        <h1><i class="fa fa-check-circle"></i> DocuSign One-Time Consent Setup</h1>
        
        <p><strong>Before you can use JWT authentication, you must grant consent to your DocuSign integration.</strong></p>
        
        <cfif IsDefined("url.code")>
            <!--- Consent was granted, exchange code for confirmation --->
            <div class="success-box">
                <h3><i class="fa fa-check"></i> Consent Granted Successfully!</h3>
                <p>Your DocuSign integration has been authorized. You can now use the DocuSign features.</p>
                <p><a href="carrier_client_info.cfm" class="button success">Go to Carrier Management</a></p>
            </div>
        <cfelse>
            <!--- Show consent instructions --->
            
            <div class="step">
                <h3><i class="fa fa-info-circle"></i> What is Consent?</h3>
                <p>DocuSign requires a one-time authorization (consent) to allow your application to access the API on behalf of your account. This is a security measure to ensure only authorized applications can send documents for signature.</p>
            </div>
            
            <div class="step">
                <h3><i class="fa fa-key"></i> Step 1: Get Your Configuration</h3>
                <p>Your integration key (Client ID) is:</p>
                <div class="code-box">
                    4c1e9d51-c2a3-45e6-ab13-d7af88981c63
                </div>
            </div>
            
            <div class="step">
                <h3><i class="fa fa-link"></i> Step 2: Click the Consent URL</h3>
                <p>Click the button below to grant consent to your DocuSign integration:</p>
                
                <cfset consentUrl = "https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation&client_id=4c1e9d51-c2a3-45e6-ab13-d7af88981c63&redirect_uri=https://developers.docusign.com/platform/auth/consent">
                
                <a href="#consentUrl#" target="_blank" class="button success large">
                    <i class="fa fa-external-link"></i> Grant Consent to DocuSign
                </a>
                
                <p style="margin-top: 20px;"><small>Or copy this URL:</small></p>
                <div class="code-box">
                    <cfoutput>#consentUrl#</cfoutput>
                </div>
            </div>
            
            <div class="step">
                <h3><i class="fa fa-sign-in"></i> Step 3: Authorize</h3>
                <ol>
                    <li>Click the consent link above</li>
                    <li>Log in to your DocuSign account if prompted</li>
                    <li>Review the permissions requested</li>
                    <li>Click "Allow Access" or "Accept"</li>
                    <li>You'll be redirected to a success page</li>
                </ol>
            </div>
            
            <div class="warning-box">
                <h4><i class="fa fa-exclamation-triangle"></i> Important Notes</h4>
                <ul>
                    <li><strong>Do this only once:</strong> Consent only needs to be granted one time per integration</li>
                    <li><strong>Use the same account:</strong> Log in with the DocuSign account that owns the Integration Key</li>
                    <li><strong>Sandbox vs Production:</strong> This is for the sandbox environment (account-d.docusign.com)</li>
                </ul>
            </div>
            
            <div class="step">
                <h3><i class="fa fa-check-square-o"></i> Step 4: Test It!</h3>
                <p>After granting consent, try sending a Move Job Agreement to DocuSign:</p>
                <ol>
                    <li>Go to carrier_client_info.cfm</li>
                    <li>Select a carrier with a Move Job Agreement</li>
                    <li>Click the green "DocuSign" button</li>
                </ol>
            </div>
            
            <hr>
            
            <h3>Troubleshooting</h3>
            
            <div class="callout warning">
                <h5>Error: "consent_required" or "unauthorized_client"</h5>
                <p>This means you haven't granted consent yet or the consent has expired. Click the consent URL above to authorize your integration.</p>
            </div>
            
            <div class="callout warning">
                <h5>Error: "invalid_client"</h5>
                <p>Check that your Integration Key is correct and that the RSA public key has been uploaded to your DocuSign app.</p>
            </div>
            
            <div class="callout warning">
                <h5>Error: "invalid_grant"</h5>
                <p>Your JWT token might be malformed or your RSA private key doesn't match the public key uploaded to DocuSign.</p>
            </div>
            
            <hr>
            
            <h3>For Production</h3>
            <p>When you're ready to move to production:</p>
            <ol>
                <li>Create a production integration in DocuSign</li>
                <li>Update the consent URL to use <code>account.docusign.com</code> (remove the <code>-d</code>)</li>
                <li>Grant consent using the production URL</li>
                <li>Update your configuration in DocuSignService.cfc</li>
            </ol>
        </cfif>
        
        <hr style="margin: 40px 0;">
        
        <p style="text-align: center;">
            <a href="carrier_search.cfm" class="button secondary">Back to Carrier Search</a>
        </p>
    </div>
</body>
</html>
