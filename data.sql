/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);


/*Insert the data into the OWNERS TABLE*/
INSERT INTO owners (full_name, age)
  VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

/*Insert the data into the SPECIES TABLE*/
INSERT INTO species (name)
  VALUES ('Pokemon'), ('Digimon');

/*Modify your inserted animals so it includes the species_id*/
UPDATE animals
  SET species_id = 2
  WHERE name LIKE '%mon';

UPDATE animals
  SET species_id = 1
  WHERE name NOT LIKE '%mon';

/*Modify your inserted animals to include owner information*/
UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
  WHERE name = 'Agumon';

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
  WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
  WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
  WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
  SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
  WHERE name IN ('Angemon', 'Boarmon');


INSERT INTO vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id)
VALUES
  (1, 1),
  (3, 2),
  (3, 1),
  (4, 2);

INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES
  (1, 1, '2020-05-24'),
  (1, 3, '2020-07-22'),
  (2, 4, '2021-02-02'),
  (3, 2, '2020-01-05'),
  (3, 2, '2020-03-08'),
  (3, 2, '2020-05-14'),
  (4, 3, '2021-05-04'),
  (5, 4, '2021-02-24'),
  (6, 2, '2019-12-21'),
  (6, 1, '2020-08-10'),
  (6, 2, '2021-04-07'),
  (7, 3, '2019-09-29'),
  (8, 4, '2020-10-03'),
  (8, 4, '2020-11-04'),
  (9, 2, '2019-01-24'),
  (9, 2, '2019-05-15'),
  (9, 2, '2020-02-27'),
  (9, 2, '2020-08-03'),
  (10, 3, '2020-05-24'),
  (10, 1, '2021-01-11');

  INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

DROP INDEX IF EXISTS idx_visits_animal_id;

DROP INDEX IF EXISTS idx_visits_vet_id;

DROP INDEX IF EXISTS idx_owners_email;

EXPLAIN ANALYZE
SELECT
  COUNT(*)
FROM
  visits
WHERE
  animal_id = 4;

CREATE INDEX idx_visits_animal_id ON visits (animal_id);

EXPLAIN ANALYZE
SELECT
  COUNT(*)
FROM
  visits
WHERE
  animal_id = 4;

EXPLAIN ANALYZE
SELECT
  *
FROM
  visits
where
  vet_id = 2;


CREATE INDEX idx_visits_vet_id ON visits (vet_id);

EXPLAIN ANALYZE
SELECT
  *
FROM
  visits
where
  vet_id = 2;

INSERT INTO owners (full_name, email) SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

EXPLAIN ANALYZE
SELECT
  *
FROM
  owners
where
  email = 'owner_18327@mail.com';

CREATE INDEX idx_owners_email ON owners (email ASC);

EXPLAIN ANALYZE
SELECT
  *
FROM
  owners
where
  email = 'owner_18327@mail.com';
