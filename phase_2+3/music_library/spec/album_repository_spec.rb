require 'album_repository'
require 'album'

def reset_students_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
  before(:each) do
    reset_students_table
  end
  
  it "returns the list of albums" do
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq 2
    expect(albums.first.id).to eq 1
    expect(albums.first.title).to eq 'Doolittle'
    expect(albums[1].release_year).to eq '1974'
    expect(albums.first.artist_id).to eq 1
  end


  it "get a single album" do 
    repo = AlbumRepository.new
    album = repo.find(1)
    expect(album.title).to eq 'Doolittle'
    expect(album.release_year).to eq '1989'
  end
  
  it "get a single album" do
    repo = AlbumRepository.new
    album = repo.find(2)
    expect(album.title).to eq 'Waterloo'
    expect(album.release_year).to eq '1974'
  end

  context "#create method" do
    it "creates a new album entry" do
      repo = AlbumRepository.new
      new_album = Album.new
      new_album.title = 'The Getaway'
      new_album.release_year = '2016'
      new_album.artist_id = 3

      repo.create(new_album)

      albums = repo.all

      expect(albums.last.id).to eq 3
      expect(albums.last.title).to eq 'The Getaway'
    end
  end

  context "#delete method" do
    it "deletes one entry" do
      repo = AlbumRepository.new
      repo.delete(1)

      albums = repo.all

      expect(albums.length).to eq 1
      expect(albums.last.id).to eq 2
    end

    it "deletes multiple entries" do
      repo = AlbumRepository.new
      repo.delete(1)
      repo.delete(2)

      albums = repo.all

      expect(albums.length).to eq 0
    end
  end

  context "#update method" do
    it "updates an entry" do
      repo = AlbumRepository.new
      album = repo.find(1)
      album.title = 'something new'
      album.release_year = '1920'
      repo.update(album)
      updated_album = repo.find(1)

      expect(updated_album.title).to eq 'something new'
      expect(updated_album.release_year).to eq '1920'
    end
  end
end