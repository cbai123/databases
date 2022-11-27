require_relative '../app'

def load_app
  @io = double :io
  @app = Application.new(
    'music_library_test',
    @io,
    AlbumRepository.new,
    #ArtistRepository.new
  )
end
def reset_students_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe Application do
  before(:each) do 
    load_app
    reset_students_table
  end

  it "it runs correctly" do
    expect(@io).to receive(:puts).with("Welcome to the music library manager!")
    expect(@io).to receive(:puts).with("What would you like to do?\n 1 - List all albums\n 2 - List all artists")
    expect(@io).to receive(:print).with("Enter your choice: ")
    expect(@io).to receive(:gets).and_return("1\n")
    expect(@io).to receive(:puts).with("Here is the list of albums:")
    expect(@io).to receive(:puts).with("* 1 - Doolittle")
    expect(@io).to receive(:puts).with("* 2 - Waterloo")
    @app.run
  end
end