# DocuSign Integration - Quick Start Guide

## 🚀 Quick Setup (5 Steps)

### 1. Run Database Script
```sql
-- Execute this SQL in your database:
admin/sql/docusign_setup.sql
```

### 2. Get DocuSign Credentials
1. Go to https://developers.docusign.com/
2. Sign up for free developer account
3. Create new app/integration
4. Get these 4 values:
   - Account ID
   - Integration Key
   - User ID
   - RSA Private Key (generate with OpenSSL)

### 3. Update Configuration
Edit `admin/components/DocuSignService.cfc` (line 5-13):

```cfml
<cfset variables.docusignConfig = {
    accountId = "YOUR_ACCOUNT_ID_HERE",
    integrationKey = "YOUR_INTEGRATION_KEY_HERE",
    userId = "YOUR_USER_ID_HERE",
    rsaPrivateKey = "YOUR_PRIVATE_KEY_HERE",
    authServer = "https://account-d.docusign.com",
    apiBaseUrl = "https://demo.docusign.net/restapi",
    oAuthBasePath = "account-d.docusign.com"
}>
```

### 4. Create Temp Directory
```bash
mkdir admin/temp
chmod 755 admin/temp
```

### 5. Test It!
1. Open `admin/carrier_client_info.cfm`
2. Select a carrier with a Move Job Agreement form
3. Click the green "DocuSign" button
4. Check your email for the signature request!

---

## 📋 What Gets Created

### Files Added:
- ✅ `admin/components/DocuSignService.cfc` - Main API service
- ✅ `admin/docusign_handler.cfm` - Send/check status handler
- ✅ `admin/docusign_callback.cfm` - Callback after signing
- ✅ `admin/sql/docusign_setup.sql` - Database schema
- ✅ `admin/carrier_client_info.cfm` - Updated with DocuSign buttons

### Database Tables:
- ✅ `carrier_docusign_envelopes` - Track sent documents
- ✅ `carrier_move_job_agreements` - Added DocuSign status columns
- ✅ `carrier_docusign_webhook_events` - For webhooks (optional)

---

## 🎯 How It Works

1. **User clicks "DocuSign" button** on Move Job Agreement form
2. **System generates PDF** from move_job_agreement.cfm template
3. **PDF sent to DocuSign** with signature fields pre-placed
4. **Carrier receives email** with link to sign document
5. **Carrier signs** electronically (13 initials + 1 signature)
6. **System auto-downloads** signed PDF when complete
7. **Status updated** to "Signed" with completion date

---

## 🎨 User Interface Changes

### Forms Table Now Shows:
- **DocuSign Status** column with colored badges
- **View PDF** button (eye icon)
- **Send to DocuSign** button (green envelope icon)
- **Check Status** button (orange refresh icon)
- Success/error messages at top of page

### Status Badges:
- 🟢 **Green "Signed"** - Completed and downloaded
- 🟠 **Orange "Awaiting Signature"** - Sent, waiting for signature
- 🔴 **Red "Declined"** - Carrier declined to sign
- ⚪ **Gray "Not Sent"** - Not yet sent to DocuSign

---

## 🔧 Common Issues & Solutions

### Issue: "Invalid email address"
**Solution**: Carrier record must have valid email in RepEmail field

### Issue: "Failed to get access token"
**Solution**: Double-check your Account ID, Integration Key, and User ID

### Issue: PDF doesn't generate
**Solution**: Verify move_job_agreement.cfm exists and form data is complete

### Issue: Signed document doesn't download
**Solution**: Check folder permissions on `admin/CarrierDocuments/`

---

## 📊 Testing Checklist

- [ ] Database tables created successfully
- [ ] DocuSign credentials configured
- [ ] Temp directory exists and writable
- [ ] Can view Move Job Agreement PDF
- [ ] "DocuSign" button appears in forms table
- [ ] Can send document to DocuSign
- [ ] Receive email from DocuSign
- [ ] Can sign document
- [ ] Status updates to "Signed"
- [ ] Signed PDF downloads to CarrierDocuments folder

---

## 🌟 Pro Tips

1. **Test in Sandbox First**: Use demo.docusign.net before production
2. **Check Email**: DocuSign sends to carrier's RepEmail field
3. **Representative Selection**: System uses AddToMoveJobAgreement flag
4. **Manual Status Check**: Click refresh icon to update status
5. **View Before Sending**: Click PDF icon to preview document

---

## 📚 Need More Help?

- **Full Documentation**: See `DOCUSIGN_SETUP_README.md`
- **Configuration Example**: See `config/docusign_config_example.cfm`
- **DocuSign Docs**: https://developers.docusign.com/
- **API Reference**: https://developers.docusign.com/docs/esign-rest-api/

---

## 🔐 Security Reminder

⚠️ **NEVER commit credentials to source control!**

Use environment variables or encrypted config files for production:
```bash
# Set environment variables
export DOCUSIGN_ACCOUNT_ID="your_account_id"
export DOCUSIGN_INTEGRATION_KEY="your_key"
```

---

## ✅ Production Deployment

When ready for production:

1. Create production DocuSign app
2. Update config to use production credentials
3. Change URLs (remove `-d` and `demo.`)
4. Test with real carrier email
5. Monitor for 24 hours
6. Enable webhooks for real-time updates

---

That's it! You're ready to use DocuSign integration. 🎉
