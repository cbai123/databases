require_relative 'lib/post_repository'
require_relative 'lib/database_connection'

DatabaseConnection.connect('blog_2')

repo = PostRepository.new

posts = repo.find_by_tag('coding')

posts.each {|post|
  puts "* #{post.id}  #{post.title}"
}