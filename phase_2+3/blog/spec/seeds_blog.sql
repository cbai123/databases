TRUNCATE TABLE posts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content) VALUES ('post title 1', 'post content 1');
INSERT INTO posts (title, content) VALUES ('post title 2', 'post content 2');

TRUNCATE TABLE comments RESTART IDENTITY;

INSERT INTO comments (name, content, post_id) VALUES('name 1', 'content 1', 1);
INSERT INTO comments (name, content, post_id) VALUES('name 2', 'content 2', 1);
INSERT INTO comments (name, content, post_id) VALUES('name 3', 'content 3', 2);
INSERT INTO comments (name, content, post_id) VALUES('name 4', 'content 4', 2);
INSERT INTO comments (name, content, post_id) VALUES('name 5', 'content 5', 1);