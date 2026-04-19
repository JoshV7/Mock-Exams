-- Run this in your Supabase SQL editor (Database > SQL Editor > New Query)

-- Create the progress table
CREATE TABLE IF NOT EXISTS exam_progress (
  id          BIGSERIAL PRIMARY KEY,
  user_name   TEXT        NOT NULL,
  paper_key   TEXT        NOT NULL,
  score       INT         NOT NULL DEFAULT 0,
  total       INT         NOT NULL DEFAULT 0,
  pct         INT         NOT NULL DEFAULT 0,
  completed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_name, paper_key)
);

-- Enable Row Level Security (recommended for public-facing apps)
ALTER TABLE exam_progress ENABLE ROW LEVEL SECURITY;

-- Allow anyone with the anon key to read and write their own rows
-- (Since we're using name-based auth, not Supabase Auth, we allow full access via anon key)
-- If you want stricter security, integrate Supabase Auth instead.
CREATE POLICY "Allow all access via anon key"
  ON exam_progress
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Optional: index for faster lookups by user name
CREATE INDEX IF NOT EXISTS idx_exam_progress_user ON exam_progress(user_name);
