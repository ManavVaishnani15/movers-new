-- SQL script to create necessary database tables for DocuSign integration

-- Table to track DocuSign envelopes
CREATE TABLE IF NOT EXISTS carrier_docusign_envelopes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carrier_id INT NOT NULL,
    form_id INT NOT NULL,
    envelope_id VARCHAR(255) NOT NULL,
    signer_email VARCHAR(255) NOT NULL,
    signer_name VARCHAR(255) NOT NULL,
    status VARCHAR(50) DEFAULT 'sent',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_carrier_id (carrier_id),
    INDEX idx_form_id (form_id),
    INDEX idx_envelope_id (envelope_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add DocuSign columns to carrier_move_job_agreements table
-- Note: Ignore "Duplicate column" errors if columns already exist
ALTER TABLE carrier_move_job_agreements 
ADD COLUMN docusign_status VARCHAR(50) DEFAULT NULL;

ALTER TABLE carrier_move_job_agreements 
ADD COLUMN docusign_envelope_id VARCHAR(255) DEFAULT NULL;

ALTER TABLE carrier_move_job_agreements 
ADD COLUMN docusign_sent_date DATETIME DEFAULT NULL;

ALTER TABLE carrier_move_job_agreements 
ADD COLUMN docusign_completed_date DATETIME DEFAULT NULL;

ALTER TABLE carrier_move_job_agreements 
ADD COLUMN signed_document_path VARCHAR(500) DEFAULT NULL;

-- Add indexes
ALTER TABLE carrier_move_job_agreements 
ADD INDEX idx_docusign_status (docusign_status);

ALTER TABLE carrier_move_job_agreements 
ADD INDEX idx_docusign_envelope (docusign_envelope_id);

-- Create table for DocuSign webhook events (optional but recommended)
CREATE TABLE IF NOT EXISTS carrier_docusign_webhook_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    envelope_id VARCHAR(255) NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_data TEXT,
    received_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    processed TINYINT(1) DEFAULT 0,
    INDEX idx_envelope_id (envelope_id),
    INDEX idx_event_type (event_type),
    INDEX idx_processed (processed)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
