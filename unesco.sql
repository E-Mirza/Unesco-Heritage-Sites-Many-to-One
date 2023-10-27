DROP TABLE unesco_raw;
CREATE TABLE unesco_raw
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
    region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER);

CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
CREATE TABLE iso (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM '/Users/u1206611/Desktop/whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;
INSERT INTO category(name) SELECT DISTINCT category FROM unesco_raw;
INSERT INTO state(name) SELECT DISTINCT state FROM unesco_raw;
INSERT INTO region(name) SELECT DISTINCT region FROM unesco_raw;
INSERT INTO iso(name) SELECT DISTINCT iso FROM unesco_raw;
UPDATE unesco_raw SET category_id = category.id FROM category WHERE unesco_raw.category = category.name;
UPDATE unesco_raw SET state_id = state.id FROM state WHERE unesco_raw.state = state.name;
UPDATE unesco_raw SET region_id = region.id FROM region WHERE unesco_raw.region = region.name;
UPDATE unesco_raw SET iso_id = iso.id FROM iso WHERE unesco_raw.iso = iso.name;
CREATE TABLE unesco(
id SERIAL,
name TEXT,
year INTEGER,
category_id INTEGER,
state_id INTEGER,
region_id INTEGER,
iso_id INTEGER,
PRIMARY KEY (id)
);
INSERT INTO unesco (name, year, category_id,state_id,region_id,iso_id) SELECT name, year, state_id, category_id, region_id, iso_id FROM unesco_raw;
SELECT unesco.name, year, category.name, state.name, region.name, iso.name
  FROM unesco
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
  ORDER BY category.name, unesco.name
  LIMIT 3;