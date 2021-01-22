CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(60),
  last_name VARCHAR(60),
  username VARCHAR(60),
  password VARCHAR(60)
  );

CREATE TABLE properties (
  property_id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  owned_by_id INT,
  
  CONSTRAINT fk_owner
   FOREIGN KEY(owned_by_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
  );

CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  property_id INT,
  user_id INT,
  start_date DATE,
  end_date DATE,
  
  CONSTRAINT fk_property
   FOREIGN KEY(property_id)
    REFERENCES properties(property_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_user
   FOREIGN KEY(user_id)
    REFERENCES users(user_id)
    ON DELETE CASCADE
  );

CREATE TABLE availability (
  availability_id SERIAL PRIMARY KEY,
  property_id INT,
  start_date DATE,
  end_date DATE,

  CONSTRAINT fk_property
    FOREIGN KEY(property_id)
    REFERENCES properties(property_id)
    ON DELETE CASCADE
);
