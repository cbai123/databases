# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: students

Columns:
id | name | cohort_name
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_blog.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

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
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 blog < seeds_blog.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: comments

# Model class
# (in lib/comment.rb)
class Comment
end

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: comments

# Model class
# (in lib/comment.rb)

class Comment
  attr_accessor :id, :name, :content, :post_id
end

# Model class
# (in lib/post.rb)

class Post
  attr_accessor :id, :title, :content, :comments
  def initialize
    @comments = []
  end
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  def find_with_comments(id)
    # Executes the SQL query:
    # SELECT posts.id, posts.title, posts.content, comments.name, comments.content AS comment_content FROM posts JOIN comments ON posts.id = comments.post_id WHERE posts.id = $1
    # params = [id]

    # Returns a single post object with an array of comment objects
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'title 1'
posts[0].content # =>  'post content 1'

posts[1].id # =>  2
posts[1].title # =>  'title 2'
posts[1].content # =>  'post content 2'

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  'title 1'
post.content # =>  'post content 1'

# 3
# Get a single post with an array of comments

repo = PostRepository.new

post = repo.find_with_comments(1)

post.id # =>  1
post.title # =>  'title 1'
post.content # =>  'post content 1'

post.comments.length # => 3
post.comments.first.name # => 'name 1'
post.comments.last.name # => 'name 5'

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb

def reset_blog_db
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_blog_db
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._