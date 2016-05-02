DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS category;

INSERT INTO users (user_name, email, password) VALUES ("alvin12", "a@b.com", "hello");

CREATE TABLE posts(
  id           SERIAL PRIMARY KEY,
  title        VARCHAR,
  img_url      VARCHAR,
  content      VARCHAR,
  time_posted  TIMESTAMPTZ default current_timestamp,
  user_id      INTEGER REFERENCES users(id)
);

INSERT INTO posts (title, img_url, content, user_id) VALUES ("Test post", "google.com", "some content", 1)

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



