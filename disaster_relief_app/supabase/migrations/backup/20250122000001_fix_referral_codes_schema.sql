-- Add missing columns expected by ReferralCodeRepository
ALTER TABLE referral_codes
  ADD COLUMN IF NOT EXISTS max_uses INT DEFAULT 3,
  ADD COLUMN IF NOT EXISTS used_count INT DEFAULT 0,
  ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;

-- Migrate existing data (only if is_consumed column exists)
DO $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'referral_codes' AND column_name = 'is_consumed'
  ) THEN
    UPDATE referral_codes SET
      used_count = CASE WHEN is_consumed THEN 1 ELSE 0 END,
      is_active = NOT is_consumed,
      max_uses = 1  -- Legacy codes are single-use
    WHERE max_uses IS NULL OR used_count IS NULL OR is_active IS NULL;
  END IF;
END $$;

-- Add constraint: used_count cannot exceed max_uses
ALTER TABLE referral_codes
  DROP CONSTRAINT IF EXISTS check_referral_uses;

ALTER TABLE referral_codes
  ADD CONSTRAINT check_referral_uses
  CHECK (used_count <= max_uses);

-- Create function to increment used_count
CREATE OR REPLACE FUNCTION increment_referral_usage(p_code TEXT)
RETURNS VOID AS $$
BEGIN
  UPDATE referral_codes
  SET
    used_count = used_count + 1,
    is_active = CASE WHEN (used_count + 1) >= max_uses THEN false ELSE true END,
    updated_at = now()
  WHERE code = p_code;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Update validation function
CREATE OR REPLACE FUNCTION validate_referral_code(p_code TEXT)
RETURNS jsonb AS $$
DECLARE
  v_code RECORD;
BEGIN
  SELECT * INTO v_code
  FROM referral_codes
  WHERE code = p_code
    AND is_active = true
    AND expires_at > now()
    AND used_count < max_uses;

  RETURN jsonb_build_object(
    'is_valid', v_code IS NOT NULL,
    'issuer_id', v_code.issuer_id,
    'issued_for_role', v_code.issued_for_role,
    'remaining_uses', CASE WHEN v_code IS NOT NULL THEN v_code.max_uses - v_code.used_count ELSE 0 END
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create RPC function for redeeming referral codes
CREATE OR REPLACE FUNCTION redeem_referral_code(code_input TEXT, user_id UUID)
RETURNS VOID AS $$
DECLARE
  v_code RECORD;
BEGIN
  -- Lock the row for update
  SELECT * INTO v_code
  FROM referral_codes
  WHERE code = code_input
    AND is_active = true
    AND expires_at > now()
    AND used_count < max_uses
  FOR UPDATE;

  IF v_code IS NULL THEN
    RAISE EXCEPTION 'Invalid, expired, or exhausted referral code';
  END IF;

  -- Increment usage count
  UPDATE referral_codes
  SET
    used_count = used_count + 1,
    is_active = CASE WHEN (used_count + 1) >= max_uses THEN false ELSE true END,
    updated_at = now()
  WHERE code = code_input;

  -- Log the redemption in audit_logs
  INSERT INTO audit_logs (
    actor_id,
    action,
    target_type,
    target_id,
    meta
  ) VALUES (
    user_id,
    'referral_code_redeemed',
    'referral_code',
    v_code.id,
    jsonb_build_object(
      'code', code_input,
      'issuer_id', v_code.issuer_id
    )
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
