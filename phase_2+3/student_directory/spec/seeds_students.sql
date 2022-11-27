TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO students (name, cohort_id) VALUES ('David', 1);
INSERT INTO students (name, cohort_id) VALUES ('Anna', 1);
INSERT INTO students (name, cohort_id) VALUES ('Chris', 2);
INSERT INTO students (name, cohort_id) VALUES ('Matt', 2);
INSERT INTO students (name, cohort_id) VALUES ('Pat', 1);