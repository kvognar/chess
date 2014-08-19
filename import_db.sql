

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

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
  ('Breakfast', 'Supper'), ('Jasmine', 'Rice');
  
INSERT INTO
  questions (title, body, author_id)
VALUES  
  ("breakfast", "What's for breakfast?", 1),
  ("name", "What's your name?", 2);
  
INSERT INTO
  replies (question_id, author_id, body)
VALUES  
  (1, 2, "Bacon and Eggs"),
  (2, 1, "My name is Breakfast");
  
INSERT INTO
  replies(question_id, parent_id, author_id, body)
VALUES
  (2, 2, 2, "Nice to meet you, Breakfast!");

INSERT INTO 
  question_followers (question_id, user_id)
VALUES
  (1, 1),
  (2, 2);
  
INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (2, 1),
  (1, 2);



