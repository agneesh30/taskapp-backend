-- =============================================
-- Migration: V3 — Create Task Audit Log Table
-- Author: TaskApp Dev Team
-- Date: 2024
-- =============================================

CREATE TABLE IF NOT EXISTS task_audit_log (
    id              UUID            DEFAULT gen_random_uuid() PRIMARY KEY,
    task_id         UUID            NOT NULL,
    changed_by      UUID            NOT NULL,
    old_status      VARCHAR(20),
    new_status      VARCHAR(20),
    change_reason   TEXT,
    changed_at      TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_audit_task_id
        FOREIGN KEY (task_id) REFERENCES tasks(id),

    CONSTRAINT fk_audit_changed_by
        FOREIGN KEY (changed_by) REFERENCES users(id)
);

-- Index for task history lookup
CREATE INDEX IF NOT EXISTS idx_audit_task_id    ON task_audit_log(task_id);
CREATE INDEX IF NOT EXISTS idx_audit_changed_at ON task_audit_log(changed_at);

COMMENT ON TABLE task_audit_log IS 'Tracks all task status changes for audit purposes';
