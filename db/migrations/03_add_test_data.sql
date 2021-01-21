INSERT INTO users_base
VALUES(1,'test_user', 'test_password');

INSERT INTO properties_base
VALUES(1,'booked_property', 1);
INSERT INTO properties_base
VALUES(2,'unbooked_property', 1);
INSERT INTO properties_base
VALUES(3,'unbooked_property', 1);

INSERT INTO bookings_base
VALUES(1, 1, 1, '2021-05-03', '2021-05-07');

INSERT INTO availability_base
VALUES(1, 1, '2021-01-01', '2021-12-31');