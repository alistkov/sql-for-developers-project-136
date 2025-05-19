DROP TABLE IF EXISTS
    programs,
    modules,
    courses,
    lessons,
    program_modules,
    course_modules,
    teaching_groups,
    users,
    enrollments,
    payments,
    program_completions,
    certificates,
    quizzes,
    exercises,
    discussions,
    blogs
    CASCADE;

CREATE TABLE programs (
    id           BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name         VARCHAR(255),
    price        INT,
    program_type VARCHAR(255),
    created_at   DATE,
    updated_at   DATE
);

CREATE TABLE modules (
    id          BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name        VARCHAR(255),
    description TEXT,
    created_at  DATE,
    updated_at  DATE,
    deleted_at  DATE
);

CREATE TABLE courses (
    id          BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name        VARCHAR(255),
    description TEXT,
    created_at  DATE,
    updated_at  DATE,
    deleted_at  DATE
);

CREATE TABLE lessons (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name       VARCHAR(255),
    content    TEXT,
    video_url  VARCHAR(255),
    position   INT,
    course_id  BIGINT REFERENCES courses (id) ON DELETE SET NULL,
    created_at DATE,
    updated_at DATE,
    deleted_at DATE
);

CREATE TABLE program_modules (
    program_id INT REFERENCES programs (id) ON DELETE CASCADE,
    module_id  INT REFERENCES modules (id) ON DELETE CASCADE,
    PRIMARY KEY (program_id, module_id)
);

CREATE TABLE course_modules (
    course_id BIGINT REFERENCES courses (id) ON DELETE SET NULL,
    module_id BIGINT REFERENCES modules (id) ON DELETE SET NULL,
    PRIMARY KEY (course_id, module_id)
);

CREATE TABLE teaching_groups (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug       VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

CREATE TYPE user_role AS ENUM ('Student', 'Admin', 'Teacher');

CREATE TABLE users (
    id                BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name              VARCHAR(255),
    role              user_role,
    email             VARCHAR(255) UNIQUE NOT NULL,
    password_hash     VARCHAR(255),
    teaching_group_id BIGINT REFERENCES teaching_groups (id) ON DELETE SET NULL,
    created_at        DATE,
    updated_at        DATE,
    deleted_at        DATE
);

CREATE TYPE subscription AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id    BIGINT,
    program_id BIGINT,
    status     subscription,
    created_at DATE,
    updated_at DATE
);

CREATE TYPE payment AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
    id            BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments (id) ON DELETE SET NULL,
    amount        DOUBLE PRECISION,
    status        payment,
    paid_at       DATE,
    created_at    DATE,
    updated_at    DATE
);

CREATE TYPE completion AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE program_completions (
    id           BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id      BIGINT REFERENCES users (id) ON DELETE SET NULL,
    program_id   BIGINT REFERENCES programs (id) ON DELETE SET NULL,
    status       completion,
    started_at   DATE,
    completed_at DATE,
    created_at   DATE,
    updated_at   DATE
);

CREATE TABLE certificates (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id    BIGINT REFERENCES users (id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs (id) ON DELETE SET NULL,
    url        VARCHAR(255),
    issued_at  DATE,
    created_at DATE,
    updated_at DATE
);

CREATE TABLE quizzes (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id  BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    name       VARCHAR(255),
    content    JSONB,
    created_at DATE,
    updated_at DATE
);

CREATE TABLE exercises (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id  BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    name       VARCHAR(255),
    url        VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

CREATE TABLE discussions (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id  BIGINT REFERENCES lessons (id) ON DELETE SET NULL,
    text       TEXT,
    user_id    BIGINT REFERENCES users (id) ON DELETE SET NULL,
    created_at DATE,
    updated_at DATE
);

CREATE TYPE status AS ENUM ('created', 'in moderation', 'published', 'archived');

CREATE TABLE blogs (
    id         BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id    BIGINT REFERENCES users (id) ON DELETE SET NULL,
    name       VARCHAR(255),
    content    TEXT,
    status     status,
    created_at DATE,
    updated_at DATE
);
