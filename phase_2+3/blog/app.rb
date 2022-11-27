require_relative 'lib/post_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog')

repo = PostRepository.new

post = repo.find_with_comments(2)

puts "#{post.title}\n#{post.content}"
puts "\nComments:"

post.comments.each{ |comment|
  puts "#{comment.name}: #{comment.content}"
}