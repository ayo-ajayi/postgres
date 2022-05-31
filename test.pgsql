DROP TABLE countries;
CREATE TABLE countries(
    id SERIAL,
    name VARCHAR(30) NOT NULL,
    code VARCHAR(3) PRIMARY KEY
);

SELECT * FROM countries;
INSERT INTO countries(name, code) VALUES ('Nigeria', 'NGA');
ALTER TABLE countries ADD language VARCHAR(20);

UPDATE countries SET language = 'English' WHERE code = 'NGA';

INSERT INTO countries (name, code, language) VALUES('Hungary', 'HUN', 'Hungarian');
INSERT INTO countries (name, code, language) VALUES('America', 'USA', 'English');

DELETE FROM countries WHERE code = 'USA';

INSERT INTO countries (name, code )SELECT 


SELECT * INTO new FROM old