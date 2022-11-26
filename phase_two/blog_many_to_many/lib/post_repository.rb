require_relative './post'

class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, title FROM posts;'

    repo = DatabaseConnection.exec_params(sql,[])

    posts = []

    repo.each { |result| 
      post = Post.new
      post.id = result["id"].to_i
      post.title = result["title"]
      posts << post
    }
    return posts

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, title FROM posts WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)

    post = Post.new
    post.id = result[0]["id"].to_i
    post.title = result[0]["title"]

    return post

    # Returns a single Post object.
  end

  def find_by_tag(tag)
    # Executes the SQL query:
    sql = 'SELECT posts.id, posts.title FROM posts JOIN posts_tags ON posts.id = posts_tags.post_id JOIN tags ON posts_tags.tag_id = tags.id WHERE tags.name = $1;'
    params = [tag]

    results = DatabaseConnection.exec_params(sql,params)

    posts = []

    results.each{ |result|
      post = Post.new
      post.id = result["id"].to_i
      post.title = result["title"]

      posts << post
    }
    return posts

    # Returns an array of Post objects
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end