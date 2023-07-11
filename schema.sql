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