# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `cohorts`*

```
# EXAMPLE

Table: cohorts

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_cohorts.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohorts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO cohorts (name, cohort_id) VALUES ('David', 1);
INSERT INTO cohorts (name, cohort_id) VALUES ('Anna', 1);
INSERT INTO cohorts (name, cohort_id) VALUES ('Chris', 2);
INSERT INTO cohorts (name, cohort_id) VALUES ('Matt', 2);
INSERT INTO cohorts (name, cohort_id) VALUES ('Pat', 1);

-- (file: spec/seeds_cohorts.sql)

TRUNCATE TABLE cohorts RESTART IDENTITY CASCADE;

INSERT INTO cohorts (cohort_name, start_date) VALUES ('January 2022', '2022-01-10')
INSERT INTO cohorts (cohort_name, start_date) VALUES ('February 2022', '2022-02-10')
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: cohorts

# Model class
# (in lib/cohort.rb)
class cohort
end

# Model class
# (in lib/cohort.rb)
class Cohort
end

# Repository class
# (in lib/cohort_repository.rb)
class CohortRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: cohorts

# Model class
# (in lib/cohort.rb)

class cohort
  attr_accessor :id, :name, :cohort_id
end

# Table name: cohorts

# Model class
# (in lib/cohort.rb)

class Cohort
  attr_accessor :id, :cohort_name, :start_date
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: cohorts

# Repository class
# (in lib/cohort_repository.rb)

class CohortRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM cohorts;

    # Returns an array of cohort objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM cohorts WHERE id = $1;

    # Returns a single cohort object.
  end

  def find_with_cohorts(id)
    # Executes the SQL query:
    # SELECT cohorts.id, cohorts.cohort_name, cohorts.start_date, cohorts.id AS cohort_id, cohorts.name FROM cohorts JOIN cohorts ON cohorts.id = cohorts.cohort_id WHERE cohorts.id = $1;
    # params = [id]

    # returns a cohort object with an array of cohort objects
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(cohort)
  # end

  # def update(cohort)
  # end

  # def delete(cohort)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all cohorts

repo = CohortRepository.new

cohorts = repo.all

cohorts.length # =>  2

cohorts[0].id # =>  1
cohorts[0].start_date # =>  '2022-01-10'
cohorts[0].cohort_name # =>  'January 2022'

cohorts[1].id # =>  2
cohorts[1].start_date # =>  '2022-02-10'
cohorts[1].cohort_name # =>  'February 2022'

# 2
# Get a single cohort

repo = CohortRepository.new

cohort = repo.find(1)

cohort.id # =>  1
cohort.cohort_name # =>  'January 2022'
cohort.start_date # =>  '2022-01-10'

# Add more examples for each method

# 3
# Get a cohort with all its students

repo = CohortRepository.new

cohort = repo.find_with_students(1)

cohort.id # => 1
cohort.cohort_name # => 'January 2022'
cohort.students.length # => 3
cohort.students.first.name # => 'David'
cohort.students[1].cohort_id # => 1
cohort.students.last.id # => 5
cohort.students.last.name # => 'Pat'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/cohort_repository_spec.rb

def reset_cohorts_table
  seed_sql = File.read('spec/seeds_cohorts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'cohorts' })
  connection.exec(seed_sql)
end

describe cohortRepository do
  before(:each) do 
    reset_cohorts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._