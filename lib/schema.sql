CREATE TABLE users(
  id           SERIAL PRIMARY KEY,
  user_name    VARCHAR,
  email        VARCHAR,
  password     VARCHAR,
  join_date    TIMESTAMPTZ default current_timestamp
);

CREATE TABLE posts(
  id           SERIAL PRIMARY KEY,
  title        VARCHAR,
  img_url      VARCHAR,
  content      VARCHAR,
  time_posted  TIMESTAMPTZ default current_timestamp,
  user_id      INTEGER REFERENCES users(id)
);

CREATE TABLE comments(
  id           SERIAL PRIMARY KEY,
  content      text,
  time_posted  TIMESTAMPTZ default current_timestamp,
  post_id      INTEGER REFERENCES posts(id),
  user_id      INTEGER REFERENCES users(id)
);

CREATE TABLE categories(
  id          SERIAL PRIMARY KEY,
  class       VARCHAR,
  post_id     INTEGER REFERENCES posts(id)
)



