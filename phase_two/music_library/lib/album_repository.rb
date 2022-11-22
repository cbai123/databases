class AlbumRepository
  def all
    sql = 'SELECT * FROM albums'

    result_set = DatabaseConnection.exec_params(sql,[])
    albums = []
    result_set.each{ |entry|
      album = Album.new
      album.id = entry["id"].to_i
      album.title = entry["title"]
      album.release_year = entry["release_year"]
      album.artist_id = entry["artist_id"].to_i

      albums << album
    }
    return albums
  end

end