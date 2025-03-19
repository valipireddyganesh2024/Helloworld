-- 1️⃣ Ensure "company" schema exists
CREATE SCHEMA IF NOT EXISTS company;

-- 2️⃣ Set the search path to "company"
SET search_path TO company;

-- 3️⃣ Create tables for Animals (3 tables)
CREATE TABLE IF NOT EXISTS company.mammals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.birds (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.reptiles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 4️⃣ Create tables for Flowers (2 tables)
CREATE TABLE IF NOT EXISTS company.flowers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.trees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 5️⃣ Create table for Aeroplane
CREATE TABLE IF NOT EXISTS company.aeroplanes (
    id SERIAL PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(100) NOT NULL
);

-- 6️⃣ Create table for School
CREATE TABLE IF NOT EXISTS company.schools (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100 NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- 7️⃣ Create 3 additional random tables
CREATE TABLE IF NOT EXISTS company.cars (
    id SERIAL PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.countries (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS company.movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL
);

-- 8️⃣ Insert data into Animals
INSERT INTO company.mammals (name) VALUES
('Lion'), ('Tiger'), ('Elephant'), ('Leopard'), ('Giraffe'),
('Panda'), ('Kangaroo'), ('Dolphin'), ('Horse'), ('Wolf');

INSERT INTO company.birds (name) VALUES
('Eagle'), ('Parrot'), ('Penguin'), ('Sparrow'), ('Owl'),
('Hawk'), ('Peacock'), ('Flamingo'), ('Crow'), ('Dove');

INSERT INTO company.reptiles (name) VALUES
('Cobra'), ('Iguana'), ('Alligator'), ('Komodo Dragon'), ('Turtle'),
('Gecko'), ('Chameleon'), ('Viper'), ('Monitor Lizard'), ('Python');

-- 9️⃣ Insert data into Flowers
INSERT INTO company.flowers (name) VALUES
('Rose'), ('Lily'), ('Tulip'), ('Sunflower'), ('Orchid'),
('Daisy'), ('Jasmine'), ('Lotus'), ('Marigold'), ('Daffodil');

INSERT INTO company.trees (name) VALUES
('Oak'), ('Pine'), ('Maple'), ('Birch'), ('Cedar'),
('Redwood'), ('Sequoia'), ('Bamboo'), ('Aspen'), ('Spruce');

-- 🔟 Insert data into Aeroplanes
INSERT INTO company.aeroplanes (model, manufacturer) VALUES
('Boeing 747', 'Boeing'), ('Airbus A380', 'Airbus'), ('Cessna 172', 'Cessna'),
('F-22 Raptor', 'Lockheed Martin'), ('Concorde', 'Aerospatiale/BAC'),
('Boeing 787', 'Boeing'), ('Airbus A320', 'Airbus'), ('Gulfstream G650', 'Gulfstream'),
('Antonov An-225', 'Antonov'), ('Boeing 737', 'Boeing');

-- 🔟 Insert data into Schools
INSERT INTO company.schools (name, location) VALUES
('Greenwood High', 'New York'), ('Sunrise Academy', 'Los Angeles'), 
('Maple Leaf School', 'Chicago'), ('Oceanview High', 'San Francisco'), 
('Riverdale Academy', 'Houston'), ('Blue Ridge School', 'Seattle'), 
('Springfield High', 'Miami'), ('Hilltop Academy', 'Denver'),
('Westwood Institute', 'Boston'), ('Redwood High', 'Dallas');

-- 🔟 Insert data into Cars
INSERT INTO company.cars (brand, model) VALUES
('Toyota', 'Camry'), ('Ford', 'Mustang'), ('Honda', 'Civic'),
('Chevrolet', 'Corvette'), ('BMW', 'X5'), ('Mercedes', 'C-Class'),
('Audi', 'A6'), ('Tesla', 'Model S'), ('Nissan', 'Altima'), ('Hyundai', 'Elantra');

-- 🔟 Insert data into Countries
INSERT INTO company.countries (country_name) VALUES
('USA'), ('Canada'), ('UK'), ('Germany'), ('France'),
('Japan'), ('Australia'), ('Brazil'), ('India'), ('South Africa');

-- 🔟 Insert data into Movies
INSERT INTO company.movies (title, genre) VALUES
('Inception', 'Sci-Fi'), ('Titanic', 'Romance'), ('The Matrix', 'Action'),
('Avatar', 'Adventure'), ('The Godfather', 'Crime'), ('Interstellar', 'Sci-Fi'),
('Joker', 'Drama'), ('Frozen', 'Animation'), ('The Dark Knight', 'Action'), ('Gladiator', 'Historical');


