CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR(60),
  password VARCHAR(60)
  );

CREATE TABLE properties (
  property_id SERIAL PRIMARY KEY,
  name VARCHAR(60),
  owned_by_id INT,
  is_available BOOLEAN,
  
  CONSTRAINT owned_by_id
   FOREIGN KEY(owned_by_id) 
    REFERENCES users(user_id)
  );

CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  property_id INT,
  user_id INT,
  
  CONSTRAINT property_id
   FOREIGN KEY(property_id) 
    REFERENCES properties(property_id),
  
  CONSTRAINT user_id
   FOREIGN KEY(user_id) 
    REFERENCES users(user_id)
  );