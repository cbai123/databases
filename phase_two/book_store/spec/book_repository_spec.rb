require 'book_repository'
require 'book'

def reset_books_table
  seed_sql = File.read('spec/seeds_books.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
  connection.exec(seed_sql)
end

RSpec.describe BookRepository do
  before(:each) do
    reset_books_table
  end

  context "#all method" do
    it "returns the list of books" do
      repo = BookRepository.new

      books = repo.all

      expect(books.length).to eq 5

      expect(books.first.id).to eq 1
      expect(books.first.title).to eq 'Nineteen Eighty-Four'
      expect(books.first.author_name).to eq 'George Orwell'

      expect(books[3].id).to eq 4
      expect(books[3].title).to eq 'Dracula'
      expect(books[3].author_name).to eq 'Bram Stoker'
    end
  end

  context "#find method" do
    it "returns book of id 3" do
    repo = BookRepository.new

    book = repo.find(3)
    
    expect(book.id).to eq 3
    expect(book.title).to eq 'Emma'
    expect(book.author_name).to eq 'Jane Austen'
    end

    it "returns book of id 5" do
      repo = BookRepository.new

      book = repo.find(5)

      expect(book.id).to eq 5
      expect(book.title).to eq 'The Age of Innocence'
      expect(book.author_name).to eq 'Edith Wharton'
    end
  end
end