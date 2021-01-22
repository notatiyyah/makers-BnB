CREATE TABLE users_base (
  user_id SERIAL PRIMARY KEY,
  first_name VARCHAR(60),
  last_name VARCHAR(60),
  username VARCHAR(60),
  password VARCHAR(60)
  );

CREATE TABLE properties_base (
  property_id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  owned_by_id INT,
  description VARCHAR, 
  price NUMERIC(2,0),
  
  CONSTRAINT fk_owner
   FOREIGN KEY(owned_by_id)
    REFERENCES users_base(user_id)
    ON DELETE CASCADE
  );

CREATE TABLE bookings_base (
  booking_id SERIAL PRIMARY KEY,
  property_id INT,
  user_id INT,
  start_date DATE,
  end_date DATE,
  
  CONSTRAINT fk_property
   FOREIGN KEY(property_id)
    REFERENCES properties_base(property_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_user
   FOREIGN KEY(user_id)
    REFERENCES users_base(user_id)
    ON DELETE CASCADE
  );

CREATE TABLE availability_base (
  availability_id SERIAL PRIMARY KEY,
  property_id INT,
  start_date DATE,
  end_date DATE,

  CONSTRAINT fk_property
    FOREIGN KEY(property_id)
    REFERENCES properties_base(property_id)
    ON DELETE CASCADE
);
