DROP TABLE IF EXISTS questions;

CREATE TABLE questions (

  id INTEGER PRIMARY KEY,
  title VARCHAR(80) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS users;

CREATE TABLE users (

  id INTEGER PRIMARY KEY,
  fname VARCHAR(80) NOT NULL,
  lname VARCHAR(80) NOT NULL

);

DROP TABLE IF EXISTS question_follows;

-- question follows is mainly to link tables together
CREATE TABLE question_follows (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)

);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (

  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  parent_reply_id  INTEGER, --because the first reply won't be tied to another reply
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)

);


DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)

);

INSERT INTO
  users (fname, lname)
VALUES
   ('Guy', 'Wassather'),
   ('Leo', 'Kanuth');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Why SQL?', 'I don''t get it. Look ma, escape character!', 2),
  ('But really though...', 'Populating this manually as we speak.', 1);

INSERT INTO
  replies (body, user_id, parent_reply_id, question_id)
VALUES
  -- ('Because, SQL!', 2, 1),
  ('Different', 2, null, 1);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (2, 2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (2, 2),
  (2, 1);






  -- id INTEGER PRIMARY KEY,
  -- body TEXT NOT NULL,
  -- author_id INTEGER NOT NULL,
  -- parent_reply_id  INTEGER, --because the first reply won't be tied to another reply
  -- question_id INTEGER NOT NULL,
