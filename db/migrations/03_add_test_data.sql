INSERT INTO users_base
VALUES(1,'test_user', 'test_password');

INSERT INTO properties_base
VALUES(1,'testing_property', 1, 'false');
INSERT INTO properties_base
VALUES(2,'testing_property', 1, 'true');
INSERT INTO properties_base
VALUES(3,'testing_property', 1, 'true');

INSERT INTO bookings_base
VALUES(1, 1, 1);

INSERT INTO availability_base (property_id, start_date, end_date)
VALUES(1, '2021-01-01', '2021-12-31');