require_relative 'lib/database_connection.rb'
require_relative'lib/album_repository'
require_relative 'lib/album'

DatabaseConnection.connect('music_library')

repo = AlbumRepository.new

# results = repo.all

# results.each{ |entry|
#   p entry
# }

p album = repo.find(3)
