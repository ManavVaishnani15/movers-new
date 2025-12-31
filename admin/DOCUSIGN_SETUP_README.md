# DocuSign Integration Setup Guide

## Overview
This integration allows you to send Move Job Agreement PDFs to carrier representatives for electronic signature via DocuSign from the carrier_client_info.cfm page.

## Features
- ✅ Generate PDF from Move Job Agreement form data
- ✅ Send PDF to DocuSign for electronic signature
- ✅ Track signature status (sent, awaiting, completed, declined)
- ✅ Auto-populate signature fields and initial fields on all 13 pages
- ✅ Download completed signed documents automatically
- ✅ Display status badges in the forms list
- ✅ Check status button for pending signatures

## Prerequisites

### 1. DocuSign Developer Account
1. Go to https://developers.docusign.com/
2. Create a free developer account (sandbox environment)
3. Create a new integration/app in the DocuSign Admin panel

### 2. Get API Credentials
You'll need:
- **Account ID**: Found in DocuSign Admin → Settings
- **Integration Key**: Created when you register your app
- **User ID**: Your DocuSign user GUID (Admin → Users → API Username)
- **RSA Private Key**: Generate an RSA keypair for JWT authentication

### 3. Generate RSA Key Pair
```bash
# Generate private key
openssl genrsa -out private.key 2048

# Generate public key
openssl rsa -in private.key -pubout -out public.key
```

Upload the public key to your DocuSign integration settings.

## Installation Steps

### Step 1: Database Setup
Run the SQL script to create necessary tables:

```sql
-- Located at: admin/sql/docusign_setup.sql
```

Execute this in your MySQL database to create:
- `carrier_docusign_envelopes` table
- Additional columns in `carrier_move_job_agreements` table
- `carrier_docusign_webhook_events` table (optional)

### Step 2: Configure DocuSign Service
Edit `admin/components/DocuSignService.cfc` and update the configuration:

```cfml
<cfset variables.docusignConfig = {
    accountId = "YOUR_DOCUSIGN_ACCOUNT_ID",           // e.g., "12345678-abcd-..."
    integrationKey = "YOUR_INTEGRATION_KEY",          // e.g., "a1b2c3d4-..."
    userId = "YOUR_USER_ID",                          // e.g., "98765432-..."
    rsaPrivateKey = "YOUR_RSA_PRIVATE_KEY",          // Full RSA private key content
    authServer = "https://account-d.docusign.com",   // -d for demo, remove for production
    apiBaseUrl = "https://demo.docusign.net/restapi", // Use demo. for sandbox
    oAuthBasePath = "account-d.docusign.com"         // -d for demo
}>
```

### Step 3: Install JWT Library (Optional)
For production JWT signing, install nimbus-jose-jwt or similar:

```xml
<!-- Add to your lib folder or use JavaLoader -->
<dependency>
    <groupId>com.nimbusds</groupId>
    <artifactId>nimbus-jose-jwt</artifactId>
    <version>9.31</version>
</dependency>
```

Or use the DocuSign SDK for CFML (if available).

### Step 4: Create Temp Directory
Ensure the temp directory exists for PDF generation:

```bash
mkdir admin/temp
```

Set appropriate permissions (write access for web server).

### Step 5: Verify File Structure
Confirm these files exist:
- ✅ `admin/components/DocuSignService.cfc`
- ✅ `admin/docusign_handler.cfm`
- ✅ `admin/docusign_callback.cfm`
- ✅ `admin/sql/docusign_setup.sql`
- ✅ `admin/carrier_client_info.cfm` (updated)

## Usage

### Sending a Document for Signature

1. **Navigate to Carrier Page**
   - Go to carrier_client_info.cfm
   - Select a carrier with saved Move Job Agreement forms

2. **Send to DocuSign**
   - In the "Saved Move Job Agreement Forms" table
   - Click the green "DocuSign" button next to any form
   - The system will:
     * Generate a PDF from the form data
     * Determine the correct carrier representative
     * Send to DocuSign with pre-placed signature/initial fields
     * Display success message

3. **Carrier Signs Document**
   - Carrier receives email from DocuSign
   - Opens document and signs electronically
   - Initials all 13 pages
   - Signs and dates on page 7

4. **Automatic Download**
   - Upon completion, signed PDF is automatically downloaded
   - Saved to `admin/CarrierDocuments/` folder
   - Status updated to "Signed" with completion date

### Checking Status

Click the orange refresh button (⟳) to manually check the current status of a pending signature.

### Status Indicators

| Status | Color | Icon | Meaning |
|--------|-------|------|---------|
| Not Sent | Gray | - | Document hasn't been sent to DocuSign |
| Awaiting Signature | Orange | 🕐 | Sent, waiting for carrier to sign |
| Signed | Green | ✓ | Completed and signed document downloaded |
| Declined | Red | ✗ | Carrier declined to sign |

## Signature Field Placement

The system automatically places signature fields at these locations:

### Initial Fields (pages 1-13)
- **Position**: Top right corner of each page
- **X**: 500, **Y**: 700

### Signature Field (page 7)
- **Position**: Near bottom where signature line appears
- **X**: 100, **Y**: 350

### Date Field (page 7)
- **Position**: Next to signature field
- **X**: 300, **Y**: 350

You can adjust these positions by editing the `sendForSignature` function in `DocuSignService.cfc`.

## Configuration Options

### Embedded vs Email Signing

**Embedded Signing** (Current Default):
- Carrier signs immediately in browser
- Requires return URL
- Better user experience

**Email Signing**:
- Carrier receives email with link
- Signs at their convenience
- Better for delayed signing

To switch to email-only signing, remove the `returnUrl` parameter when calling `sendForSignature`.

### Custom Email Subject
Edit in `DocuSignService.cfc`:
```cfml
"emailSubject": "Please sign: Move Job Acceptance Agreement"
```

## Troubleshooting

### "Invalid email address" Error
- Verify carrier has valid email in RepEmail/Rep2Email/Rep3Email
- Check AddToMoveJobAgreement flags (1, 2, or 3)

### "Failed to get access token" Error
- Verify Account ID, Integration Key, User ID are correct
- Ensure RSA private key is properly formatted
- Check if integration is enabled in DocuSign Admin

### "Document was signed but error downloading"
- Check folder permissions on `admin/CarrierDocuments/`
- Verify web server has write access

### PDF Generation Issues
- Ensure move_job_agreement.cfm is accessible
- Check for ColdFusion/Lucee PDF rendering errors
- Verify all form data is properly populated

### JWT Token Issues
For production, implement proper JWT signing:
```cfml
// Use Java library for RS256 signing
<cfset jwtToken = createJWTWithRSA(jwtHeader, jwtPayload, privateKey)>
```

## Security Best Practices

1. **Protect API Credentials**
   - Store in Application scope, not in code
   - Use environment variables or encrypted config
   - Never commit credentials to source control

2. **Validate Webhook Signatures**
   - When using webhooks, verify DocuSign's HMAC signature
   - Prevents unauthorized status updates

3. **Secure Return URLs**
   - Use HTTPS only
   - Validate session before processing callbacks

4. **Access Control**
   - Ensure only authorized users can send documents
   - Verify user permissions before displaying DocuSign buttons

## Production Checklist

Before going live:

- [ ] Change from demo/sandbox to production DocuSign account
- [ ] Update API endpoints (remove `-d` and `demo.`)
- [ ] Implement proper JWT token signing
- [ ] Move credentials to secure configuration
- [ ] Test with real carrier emails
- [ ] Set up webhook handlers for real-time status updates
- [ ] Configure proper logging and error handling
- [ ] Test document download and storage
- [ ] Verify all signature field positions are correct
- [ ] Set up monitoring and alerts

## API Rate Limits

DocuSign API limits:
- **Sandbox**: 1,000 calls per hour
- **Production**: Contact DocuSign for limits based on your plan

Monitor your usage to avoid throttling.

## Support Resources

- **DocuSign Developer Center**: https://developers.docusign.com/
- **API Documentation**: https://developers.docusign.com/docs/esign-rest-api/
- **Support Forum**: https://community.docusign.com/

## Customization

### Adding More Signature Fields
Edit `sendForSignature` in DocuSignService.cfc:
```cfml
"signHereTabs": [
    {
        "documentId": "1",
        "pageNumber": "7",
        "xPosition": "100",
        "yPosition": "350"
    },
    // Add more signature tabs here
],
```

### Custom Email Templates
Create custom email templates in DocuSign and reference by template ID:
```cfml
"emailSubject": "Custom Subject",
"emailBody": "Custom message to carrier..."
```

### Webhook Integration
For real-time status updates, set up webhooks:

1. Create webhook endpoint: `admin/docusign_webhook.cfm`
2. Configure in DocuSign Admin → Connect
3. Process events: sent, delivered, completed, declined

## File Structure

```
admin/
├── components/
│   └── DocuSignService.cfc          # Main DocuSign API wrapper
├── letters/
│   └── move_job_agreement.cfm       # PDF template
├── CarrierDocuments/                # Signed PDFs storage
├── temp/                            # Temporary PDF generation
├── sql/
│   └── docusign_setup.sql          # Database schema
├── carrier_client_info.cfm         # Main page with integration
├── docusign_handler.cfm            # Send/status check handler
└── docusign_callback.cfm           # Return URL handler
```

## Version History

**v1.0** (Initial Release)
- Send Move Job Agreement to DocuSign
- Track signature status
- Auto-download signed documents
- Status display in forms table
- Manual status refresh

## License & Credits

This integration uses the DocuSign eSignature REST API.
Requires active DocuSign account and API access.

---

For questions or issues, please contact your system administrator.
