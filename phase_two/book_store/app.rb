require_relative 'lib/database_connection'
require_relative 'lib/book_repository'
require_relative 'lib/book'

DatabaseConnection.connect('book_store')

repo = BookRepository.new

books = repo.all

books.each{ |book| 
  puts "#{book.id} - #{book.title} - #{book.author_name}"
}