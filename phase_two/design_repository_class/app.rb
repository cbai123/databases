require_relative 'lib/database_connection.rb'

DatabaseConnection.connect('music_library')

sql = 'SELECT id,title FROM albums;'

result = DatabaseConnection.exec_params(sql, [])

result.each{ |record| 
  p record
}