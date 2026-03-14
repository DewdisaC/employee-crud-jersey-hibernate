CREATE DATABASE IF NOT EXISTS employee_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE employee_db;

CREATE TABLE IF NOT EXISTS employees (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO employees (name, position, department, hire_date, salary)
VALUES
('Sameera Dewaka', 'Software Engineer', 'IT', '2023-01-15', 150000.00),
('Nadeesha Perera', 'HR Manager', 'HR', '2022-05-10', 120000.00),
('Kasun Silva', 'Accountant', 'Finance', '2021-09-20', 110000.00);
