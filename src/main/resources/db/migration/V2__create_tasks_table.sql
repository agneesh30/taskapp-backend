-- =============================================
-- Migration: V2 — Create Tasks Table
-- Author: TaskApp Dev Team
-- Date: 2024
-- =============================================

CREATE TABLE IF NOT EXISTS tasks (
    id              UUID            DEFAULT gen_random_uuid() PRIMARY KEY,
    title           VARCHAR(200)    NOT NULL,
    description     TEXT,
    priority        VARCHAR(20)     NOT NULL DEFAULT 'MEDIUM',
    status          VARCHAR(20)     NOT NULL DEFAULT 'TODO',
    due_date        DATE,
    created_by      UUID            NOT NULL,
    assigned_to     UUID,
    created_at      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP       NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_task_created_by
        FOREIGN KEY (created_by) REFERENCES users(id),

    CONSTRAINT fk_task_assigned_to
        FOREIGN KEY (assigned_to) REFERENCES users(id),

    CONSTRAINT chk_priority
        CHECK (priority IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),

    CONSTRAINT chk_status
        CHECK (status IN ('TODO', 'IN_PROGRESS', 'DONE', 'CLOSED'))
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_tasks_status      ON tasks(status);
CREATE INDEX IF NOT EXISTS idx_tasks_assigned_to ON tasks(assigned_to);
CREATE INDEX IF NOT EXISTS idx_tasks_created_by  ON tasks(created_by);
CREATE INDEX IF NOT EXISTS idx_tasks_priority    ON tasks(priority);

COMMENT ON TABLE tasks IS 'Stores all tasks in the system';
COMMENT ON COLUMN tasks.status IS 'TODO | IN_PROGRESS | DONE | CLOSED';
COMMENT ON COLUMN tasks.priority IS 'LOW | MEDIUM | HIGH | CRITICAL';
