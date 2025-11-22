-- Create role upgrade requests table
CREATE TABLE role_upgrade_requests (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  from_role TEXT NOT NULL,
  to_role TEXT NOT NULL,
  unit TEXT,  -- Organization/unit for Leader申請
  reason TEXT,  -- Justification
  referral_code TEXT,  -- Required for Leader→Admin
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
  reviewed_by UUID REFERENCES auth.users(id),
  reviewed_at TIMESTAMPTZ,
  review_reason TEXT,  -- Rejection reason
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Enable RLS
ALTER TABLE role_upgrade_requests ENABLE ROW LEVEL SECURITY;

-- Allow users to view their own requests
CREATE POLICY role_upgrade_select ON role_upgrade_requests
  FOR SELECT USING (
    auth.uid() = user_id OR is_admin_or_above()
  );

-- Allow users to create upgrade requests
CREATE POLICY role_upgrade_insert ON role_upgrade_requests
  FOR INSERT WITH CHECK (
    auth.uid() = user_id AND status = 'pending'
  );

-- Only Admin+ can update (review) requests
CREATE POLICY role_upgrade_update ON role_upgrade_requests
  FOR UPDATE USING (
    is_admin_or_above()
  );

-- Create index for pending requests查詢
CREATE INDEX idx_role_upgrade_pending
  ON role_upgrade_requests(status, created_at DESC)
  WHERE status = 'pending';

-- Add trigger to update timestamps
CREATE TRIGGER trg_role_upgrade_updated
  BEFORE UPDATE ON role_upgrade_requests
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- Log approvals/rejections to audit_logs
CREATE OR REPLACE FUNCTION log_role_upgrade_review()
RETURNS TRIGGER AS $$
BEGIN
  IF (OLD.status = 'pending' AND NEW.status IN ('approved', 'rejected')) THEN
    INSERT INTO audit_logs (
      actor_id,
      action,
      target_type,
      target_id,
      meta
    ) VALUES (
      NEW.reviewed_by,
      CASE WHEN NEW.status = 'approved' THEN 'role_upgrade_approved'
           ELSE 'role_upgrade_rejected' END,
      'role_upgrade_request',
      NEW.id,
      jsonb_build_object(
        'user_id', NEW.user_id,
        'from_role', NEW.from_role,
        'to_role', NEW.to_role,
        'reason', NEW.review_reason
      )
    );

    -- If approved, update user role
    IF NEW.status = 'approved' THEN
      UPDATE profiles_public
      SET role = NEW.to_role, updated_at = now()
      WHERE id = NEW.user_id;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_log_role_upgrade_review
  AFTER UPDATE ON role_upgrade_requests
  FOR EACH ROW EXECUTE PROCEDURE log_role_upgrade_review();
