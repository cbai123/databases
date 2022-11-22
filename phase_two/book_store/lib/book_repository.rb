require_relative './book'

class BookRepository
  def all
    sql = 'SELECT * FROM books;'

    result_set = DatabaseConnection.exec_params(sql,[])

    books = []
    result_set.each{ |entry|
      book = Book.new
      book.id = entry["id"].to_i
      book.title = entry["title"]
      book.author_name = entry["author_name"]

      books << book
    }
    
    return books
  end
  
  def find(id)
    sql = "SELECT * FROM books WHERE id = #{id}"

    result = DatabaseConnection.exec_params(sql,[])

    book = Book.new
    result.each{ |entry| 
      book.id = entry["id"].to_i
      book.title = entry["title"]
      book.author_name = entry["author_name"]
    }
    return book
  end
end