require 'post_repository'
require 'post'
require 'comment'

def reset_blog_db
  seed_sql = File.read('spec/seeds_blog.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'blog' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_blog_db
  end

  # 1
  it "Get all posts" do
    repo = PostRepository.new

    posts = repo.all

    posts.length # =>  2

    expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq 'post title 1'
    expect(posts[0].content).to eq 'post content 1'

    expect(posts[1].id).to eq 2
    expect(posts[1].title).to eq 'post title 2'
    expect(posts[1].content).to eq 'post content 2'
  end

  # 2
  it "Get a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq 1
    expect(post.title).to eq 'post title 1'
    expect(post.content).to eq 'post content 1'
  end
  # 3
  it "Get a single post with an array of comments" do

    repo = PostRepository.new

    post = repo.find_with_comments(1)

    expect(post.id).to eq 1
    expect(post.title).to eq 'post title 1'
    expect(post.content).to eq 'post content 1'

    expect(post.comments.length).to eq 3
    expect(post.comments.first.name).to eq 'name 1'
    expect(post.comments.last.content).to eq 'content 5'
  end
end