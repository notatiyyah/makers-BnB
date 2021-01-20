CREATE TABLE users_base as (select * from users) with no data;
CREATE TABLE properties_base as (select * from properties) with no data;
CREATE TABLE bookings_base as (select * from bookings) with no data;

INSERT INTO users_base
VALUES(1,'test_user', 'test_password');

INSERT INTO properties_base
VALUES(1,'testing_property', 1, 'true');
INSERT INTO properties_base
VALUES(2,'testing_property', 1, 'true');
INSERT INTO properties_base
VALUES(1,'testing_property', 1, 'false');

INSERT INTO bookings_base
VALUES(1, 1, 1);