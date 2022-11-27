TRUNCATE TABLE user_accounts RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('user.1@hotmail.com', 'username_1');
INSERT INTO user_accounts (email_address, username) VALUES ('user.2@hotmail.com', 'username_2');