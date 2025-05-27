-- Active: 1747711868461@@127.0.0.1@5432@conservation_db@public
CREATE DATABASE conservation_db;

CREATE TABLE rangers(
    ranger_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL
);

INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range');

CREATE TABLE species(
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(100) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(50) NOT NULL
);

INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

CREATE TABLE sightings(
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INT REFERENCES rangers(ranger_id),
    species_id INT REFERENCES species(species_id),
    sighting_time TIMESTAMP NOT NULL,
    location VARCHAR(250) NOT NULL,
    notes TEXT
);

INSERT INTO sightings (ranger_id, species_id, sighting_time, location, notes) VALUES
(1, 1, '2024-05-10 07:45:00', 'Peak Ridge', 'Camera trap image captured'),
(2, 2, '2024-05-12 16:20:00', 'Bankwood Area', 'Juvenile seen'),
(3, 3, '2024-05-15 09:10:00', 'Bamboo Grove East', 'Feeding observed'),
(2, 1, '2024-05-18 18:30:00', 'Snowfall Pass', NULL);


SELECT * FROM rangers;
SELECT * FROM species;
SELECT * FROM sightings;


-- Problem 1
INSERT INTO rangers (name, region) VALUES
    ('Derek Fox', 'Coastal Plains');

-- Problem 2
SELECT COUNT(DISTINCT species_id) as unique_species_count FROM sightings;

-- Problem 3
SELECT * FROM sightings WHERE location ILIKE '%Pass%';

-- Problem 4
SELECT name, COUNT(*) AS total_sightings FROM rangers
  INNER JOIN sightings USING (ranger_id)
   GROUP BY name;


-- Problem 5
  SELECT common_name FROM species
    WHERE species_id NOT IN (SELECT species_id FROM sightings);


-- problem 6
SELECT common_name, sighting_time, name FROM sightings
   JOIN rangers USING (ranger_id)
  JOIN species USING (species_id)
  ORDER BY sighting_time DESC LIMIT 2;

-- Problem 7
UPDATE species
SET conservation_status = 'Historic'
 WHERE discovery_date < '1800-01-01';


-- Problem 8
 SELECT sighting_id,
  CASE
    WHEN sighting_time::TIME < '12:00:00' THEN 'Morning'
    WHEN sighting_time::TIME BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
    WHEN sighting_time::TIME > '17:00:00' THEN 'Evening'
  END
   AS time_of_day
  FROM sightings;

-- Problem 9
 DELETE FROM rangers
  WHERE ranger_id NOT IN (SELECT ranger_id FROM sightings);
