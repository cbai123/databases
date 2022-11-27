require_relative './tag'
require_relative './database_connection'
class TagRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name FROM tags;'

    results = DatabaseConnection.exec_params(sql,[])

    tags = []
    results.each {|result|
      tag = Tag.new
      tag.id = result["id"].to_i
      tag.name = result["name"]

      tags << tag
    }
    return tags

    # Returns an array of Tag objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    sql = 'SELECT id, name FROM tags WHERE id = $1;'
    params = [id]

    result = DatabaseConnection.exec_params(sql,params)
    tag = Tag.new
    tag.id = result.first["id"].to_i
    tag.name = result.first["name"]

    return tag

    # Returns a single Tag object.
  end

  def find_by_post(id)
  # Executes the SQL query:
  sql = 'SELECT tags.id, tags.name FROM tags JOIN posts_tags ON tags.id = posts_tags.tag_id JOIN posts ON posts_tags.post_id = posts.id WHERE posts.id = $1;'
  params = [id]

  tags = []
  results = DatabaseConnection.exec_params(sql,params)
  results.each{|result|
    tag = Tag.new
    tag.id = result["id"]
    tag.name = result["name"]

    tags << tag
  }

  return tags
  # Returns an array of Tag objects
  end
end