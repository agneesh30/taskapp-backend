-- =============================================
-- Migration: V1 — Create Users Table
-- Author: TaskApp Dev Team
-- Date: 2024
-- =============================================

CREATE TABLE IF NOT EXISTS users (
    id              UUID            DEFAULT gen_random_uuid() PRIMARY KEY,
    full_name       VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL,
    role            VARCHAR(20)     NOT NULL DEFAULT 'MEMBER',
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_role CHECK (role IN ('ADMIN', 'TEAM_LEAD', 'MEMBER'))
);

-- Index for email lookup
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Index for role filtering
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

COMMENT ON TABLE users IS 'Stores all application users';
COMMENT ON COLUMN users.role IS 'ADMIN | TEAM_LEAD | MEMBER';
