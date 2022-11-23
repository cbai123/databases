require 'database_connection'
require 'post'

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT * FROM posts;'

    results = DatabaseConnection.exec_params(sql,[])

    posts = []
    results.each{ |entry| 
      post = Post.new
      post.id = entry["id"].to_i
      post.title = entry["title"]
      post.content = entry["content"]
      post.views = entry["views"].to_i
      post.user_account_id = entry["user_account_id"].to_i

      posts << post
    }

    return posts

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT * FROM posts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)

    post = Post.new
    post.id = result[0]["id"].to_i
    post.title = result[0]["title"]
    post.content = result[0]["content"]
    post.views = result[0]["views"].to_i
    post.user_account_id = result[0]["user_account_id"].to_i

    return post
    # Returns a single Post object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # Executes the SQL query:
    sql = 'INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);'
    params = [post.title, post.content, post.views, post.user_account_id]

    DatabaseConnection.exec_params(sql,params)

    return nil
    # Returns nothing
  end

  def update(post)
  # Executes the SQL query:
  sql = 'UPDATE posts SET title = $1, content = $2, views = $3, user_account_id = $4 WHERE id = $5;'
  params = [post.title, post.content, post.views, post.user_account_id, post.id]

  DatabaseConnection.exec_params(sql,params)

  return nil
  # Returns nothing
  end

  def delete(id)
    # Executes the SQL query:
    sql = 'DELETE FROM posts WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql,params)

    return nil
  end
end