CREATE DATABASE work_user3
GO
USE work_user3
GO
CREATE TABLE projects
(
	id_projects			INT IDENTITY(10001, 1)	NOT NULL,
	name				VARCHAR(45)		NOT NULL,
	description			VARCHAR(45)		NULL,
	date_proj			DATE			NOT NULL CHECK(date_proj < GETDATE()) 
	PRIMARY KEY (id_projects)
)
GO
CREATE TABLE users
(
	id_users			INT IDENTITY(1, 1)	NOT NULL,
	name				VARCHAR(45)		NOT NULL,
	username			VARCHAR(45)		NOT NULL,
	password			VARCHAR(45)		NOT NULL DEFAULT('123mudar'),
	email				VARCHAR(45)		NOT NULL
	PRIMARY KEY (id_users),
	CONSTRAINT UQ_username UNIQUE (username)
)
GO
CREATE TABLE users_has_projects
(
	id_users			INT			NOT NULL,
	id_projects			INT			NOT NULL
	PRIMARY KEY(id_users, id_projects)
	FOREIGN KEY(id_users) REFERENCES users(id_users),
	FOREIGN KEY(id_projects) REFERENCES projects(id_projects)
)
GO
ALTER TABLE users 
DROP CONSTRAINT UQ_username
GO
ALTER TABLE users 
ALTER COLUMN username VARCHAR(10) NOT NULL
GO
ALTER TABLE users 
ADD CONSTRAINT UQ_username UNIQUE (username)
GO
ALTER TABLE users 
ALTER COLUMN password VARCHAR(8) NOT NULL
GO
INSERT INTO users (name, username, email) VALUES
('Maria', 'Rh_maria', 'maria@empresa.com')
GO
INSERT INTO users (name, username, password, email) VALUES
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')
GO
INSERT INTO users (name, username, email) VALUES
('Ana', 'Rh_ana', 'ana@empresa.com'),
('Clara', 'Ti_clara', 'clara@empresa.com')
GO
INSERT INTO users (name, username, password, email) VALUES
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
GO
INSERT INTO projects (name, description, date_proj)
VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção PC´s', 'Manutenção PC''s', '2014-09-06'),
('Auditoria', NULL, '2014-09-07')
GO
INSERT INTO users_has_projects (id_users, id_projects)
VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)
GO
UPDATE projects 
SET date_proj = '2014-09-12'
WHERE name LIKE 'Manutenção%'
GO
UPDATE users
SET username = 'Rh_cido'
WHERE name LIKE '%Aparecido'
GO 
UPDATE users 
SET password = '888@*'
WHERE username LIKE '%Rh_maria' AND password = '123mudar'
GO 
DELETE users_has_projects WHERE id_users = 2 AND id_projects = 10002
--------------------------ExercWork3Join-----------------------------

--a)
INSERT INTO users (name, username, email)
VALUES ('Joao', 'Ti_joao', 'joao@empresa.com')

--b)
INSERT INTO projects 
VALUES ('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PC''s', '2014-09-12')

--c)
--1)
--SQL 3
SELECT u.id_users, u.name, u.email, p.id_projects, p.name, p.description, p.date_proj 
FROM users u, projects p, users_has_projects uhp
WHERE u.id_users = uhp.id_users AND p.id_projects = uhp.id_projects AND p.name = 'Re-Folha' 

--SQL 2
SELECT u.id_users, u.name, u.email, p.id_projects, p.name, p.description, p.date_proj 
FROM users u 
INNER JOIN users_has_projects uhp ON u.id_users = uhp.id_users 
INNER JOIN projects p ON p.id_projects = uhp.id_projects 
WHERE p.name = 'Re-Folha' 

--2)
SELECT p.name  
FROM projects p 
LEFT JOIN users_has_projects uhp ON p.id_projects = uhp.id_projects
WHERE uhp.id_users IS NULL

--3)
SELECT u.name 
FROM users u 
LEFT JOIN users_has_projects uhp ON u.id_users = uhp.id_users 
WHERE uhp.id_projects IS NULL 
