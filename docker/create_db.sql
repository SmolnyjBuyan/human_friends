CREATE DATABASE human_friends;

USE human_friends;

DROP TABLE IF EXISTS cats;
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS hamsters;
DROP TABLE IF EXISTS camels;
DROP TABLE IF EXISTS horses;
DROP TABLE IF EXISTS donkeys;
DROP TABLE IF EXISTS pet_commands;
DROP TABLE IF EXISTS pack_animal_commands;
DROP TABLE IF EXISTS commands;
DROP TABLE IF EXISTS pack_animals;
DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS animal_types;
DROP TABLE IF EXISTS gender_identities;

CREATE TABLE animal_types (
	id INT UNSIGNED PRIMARY KEY,
    type VARCHAR(45) UNIQUE NOT NULL
);

CREATE TABLE gender_identities (
	id TINYINT PRIMARY KEY,
    gender VARCHAR(6) UNIQUE NOT NULL
);

CREATE TABLE pets (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    birth_date DATE NOT NULL,
    gender_id TINYINT NOT NULL,
    animal_type_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(animal_type_id) REFERENCES animal_types(id),
    FOREIGN KEY(gender_id) REFERENCES gender_identities(id),
    CONSTRAINT pets_alt_pk UNIQUE (id, animal_type_id)
);

CREATE TABLE pack_animals (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    birth_date DATE NOT NULL,
    gender_id TINYINT NOT NULL,
    animal_type_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(animal_type_id) REFERENCES animal_types(id),
    FOREIGN KEY(gender_id) REFERENCES gender_identities(id),
    CONSTRAINT pack_animals_alt_pk UNIQUE (id, animal_type_id)
    
);

CREATE TABLE cats (
    id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (1) STORED,
    CONSTRAINT fk_cat FOREIGN KEY(id, animal_type_id) REFERENCES pets(id, animal_type_id)
	ON DELETE CASCADE
);
    
CREATE TABLE dogs (
	id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (2) STORED,
    CONSTRAINT fk_dog FOREIGN KEY(id, animal_type_id) REFERENCES pets(id, animal_type_id)
    ON DELETE CASCADE
);

CREATE TABLE hamsters (
	id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (3) STORED,
    CONSTRAINT fk_hamster FOREIGN KEY(id, animal_type_id) REFERENCES pets(id, animal_type_id)
    ON DELETE CASCADE
);

CREATE TABLE camels (
	id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (4) STORED,
    CONSTRAINT fk_camel FOREIGN KEY(id, animal_type_id) REFERENCES pack_animals(id, animal_type_id)
    ON DELETE CASCADE
);

CREATE TABLE horses (
	id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (5) STORED,
    CONSTRAINT fk_horses FOREIGN KEY(id, animal_type_id) REFERENCES pack_animals(id, animal_type_id)
    ON DELETE CASCADE
);

CREATE TABLE donkeys (
	id INT UNSIGNED PRIMARY KEY,
    animal_type_id INT UNSIGNED GENERATED ALWAYS AS (6) STORED,
    CONSTRAINT fk_donkey FOREIGN KEY(id, animal_type_id) REFERENCES pack_animals(id, animal_type_id)
    ON DELETE CASCADE
);


CREATE TABLE commands (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) UNIQUE NOT NULL
);

CREATE TABLE pet_commands (
    pet_id INT UNSIGNED NOT NULL,
	command_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(pet_id, command_id),
	FOREIGN KEY(pet_id) REFERENCES pets(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY(command_id) REFERENCES commands(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE pack_animal_commands (
    pack_animal_id INT UNSIGNED NOT NULL,
	command_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(pack_animal_id, command_id),
	FOREIGN KEY(pack_animal_id) REFERENCES pack_animals(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
    FOREIGN KEY(command_id) REFERENCES commands(id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
