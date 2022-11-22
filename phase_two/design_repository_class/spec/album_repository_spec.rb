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

  context "returns one album" do
    it "returns with id 1" do
      repo = AlbumRepository.new

      album = repo.find(1)

      expect(album.id).to eq 1
      expect(album.title).to eq 'Doolittle'
      expect(album.release_year).to eq '1989'
    end

    it "returns with id 2" do
      repo = AlbumRepository.new

      album = repo.find(2)

      expect(album.id).to eq 2
      expect(album.title).to eq 'Waterloo'
      expect(album.release_year).to eq '1974'
    end
  end
end