require_relative './post'
require_relative './comment'
require_relative './database_connection'

class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title, content FROM posts;'

    result_set = DatabaseConnection.exec_params(sql,[])

    posts = []
    result_set.each { |result|
      post = Post.new
      post.id = result["id"].to_i
      post.title = result["title"]
      post.content = result["content"]

      posts << post
    }

    return posts
    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, title, content FROM posts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)

    post = Post.new
    post.id = result[0]["id"].to_i
    post.title = result[0]["title"]
    post.content = result[0]["content"]

    return post
    # Returns a single Student object.
  end

  def find_with_comments(id)
    # Executes the SQL query:
    sql = 'SELECT posts.id, posts.title, posts.content, comments.id AS comment_id, comments.name, comments.content AS comment_content FROM posts JOIN comments ON posts.id = comments.post_id WHERE posts.id = $1'
    params = [id]

    results = DatabaseConnection.exec_params(sql,params)

    post = Post.new
    post.id = results[0]["id"].to_i
    post.title = results[0]["title"]
    post.content = results[0]["content"]

    results.each {|result|
      comment = Comment.new
      comment.id = result["comment_id"]
      comment.name = result["name"]
      comment.content = result["comment_content"]

      post.comments << comment
    }

    return post
    # Returns a single post object with an array of comment objects
  end
end