/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id              INT PRIMARY KEY NOT NULL,
  name            VARCHAR(100) NOT NULL,
  date_of_birth   DATE,
  escape_attempts INT,
  neutered        BOOLEAN,
  weight_kg       DECIMAL(10, 2)
);

/* I altered the table to autogenerate the ID  */

ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

/* Add the Species Column  */

ALTER TABLE animals
ADD species VARCHAR(100);

/*Create a table named owners*/
CREATE TABLE owners (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);

/*Create a table named species*/
CREATE TABLE species (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100)
);

/*Modify animals table*/
ALTER TABLE animals
  DROP COLUMN species;

ALTER TABLE animals
  ADD COLUMN species_id INTEGER;

ALTER TABLE animals
  ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
  ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
      REFERENCES species(id);

ALTER TABLE animals
  ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id)
      REFERENCES owners(id);

CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100),
  age INTEGER,
  date_of_graduation DATE
);