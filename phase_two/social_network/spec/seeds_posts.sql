TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_account_id) VALUES ('title_1', 'content_1', 100, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title_2', 'content_2', 254, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title_3', 'content_3', 54, 2);