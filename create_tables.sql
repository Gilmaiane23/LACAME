CREATE TABLE if NOT EXISTS Users(
	user_id	int AUTO_INCREMENT,
	user_name 	VARCHAR(70) NOT NULL,
	user_email	VARCHAR(320) UNIQUE NOT NULL,
	user_password	VARCHAR(64) NOT NULL,
	phone_number	VARCHAR(20) UNIQUE NOT NULL,
	adm_permission	BOOL NOT NULL DEFAULT false,
	last_login TIMESTAMP DEFAULT NULL,
	CONSTRAINT pk_user_id PRIMARY KEY(user_id)
);

CREATE TABLE if NOT EXISTS Projects(
	project_id int AUTO_INCREMENT,
	owner_id int NOT NULL,
	created_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	end_in TIMESTAMP NOT NULL,
	project_name VARCHAR(50) NOT NULL,
	CONSTRAINT pk_project_id PRIMARY KEY(project_id),
	CONSTRAINT fk_projects_owner_id FOREIGN KEY (owner_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE if NOT EXISTS ProjectUser(
	project_id int NOT NULL,
	user_id int NOT NULL,
	CONSTRAINT fk_projectuser_project_id FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
	CONSTRAINT fk_projectuser_user_id FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
	CONSTRAINT pk_project_user PRIMARY KEY (project_id, user_id)
);

CREATE TABLE if NOT EXISTS Tasks(
	task_id int AUTO_INCREMENT,
	project_id int NOT NULL,
	owner_id int NOT NULL,
	begin_in TIMESTAMP NOT NULL,
	end_in TIMESTAMP NOT NULL,
	task_name VARCHAR(50) NOT NULL,
	task_description TEXT NOT NULL,
	task_status TINYINT(1) DEFAULT '0',
	CONSTRAINT pk_task_id PRIMARY KEY (task_id),
	CONSTRAINT fk_tasks_project_id FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
	CONSTRAINT fk_tasks_owner_id FOREIGN KEY (owner_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE if NOT EXISTS Anexos(
	anexo_uuid VARCHAR(64) NOT NULL,
	task_id int NOT NULL,
	owner_id int NOT NULL,
	anexo_name VARCHAR(70) NOT NULL,
	anexo_description TEXT NOT NULL,
	file_extension VARCHAR(5) NOT NULL,
	created_in TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT pk_anexo_uuid PRIMARY KEY (anexo_uuid),
	CONSTRAINT fk_anexos_task_id FOREIGN KEY (task_id) references Tasks(task_id) ON DELETE CASCADE,
	CONSTRAINT fk_anexos_owner_id FOREIGN KEY (owner_id) references Users(user_id) ON DELETE CASCADE
);