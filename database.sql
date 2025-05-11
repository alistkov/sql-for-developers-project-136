CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    price INT,
    type VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    description TEXT,
    created_at DATE,
    updated_at DATE
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    description TEXT,
    created_at DATE,
    update_at DATE
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    content TEXT,
    video_url VARCHAR(255),
    position INT,
    create_at DATE,
    update_at DATE
    course_id BIGINT REFERENCES courses (id) ON DELETE SET NULL
);

CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slub VARCHAR(255),
    created_at DATE,
    updated_at DATE
);

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255),
    teaching_group_id BIGINT REFERENCES teaching_groups (id) ON DELETE SET NULL,
    created_at DATE,
    updated_at DATE
);
