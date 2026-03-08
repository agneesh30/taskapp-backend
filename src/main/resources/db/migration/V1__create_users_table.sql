-- =============================================
-- Migration: V1 — Create Users Table
-- Author: TaskApp Dev Team
-- Date: 2024
-- =============================================



-- Index for email lookup
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Index for role filtering
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

COMMENT ON TABLE users IS 'Stores all application users';
COMMENT ON COLUMN users.role IS 'ADMIN | TEAM_LEAD | MEMBER';
