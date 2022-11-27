require 'post'
require 'post_repository'

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

RSpec.describe PostRepository do
  before(:each) do 
    reset_posts_table
  end
  # 1
  it "Gets all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 3

    expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq 'title_1'
    expect(posts[0].content).to eq 'content_1'
    expect(posts[0].views).to eq 100
    expect(posts[0].user_account_id).to eq 1

    expect(posts[2].id).to eq 3
    expect(posts[2].title).to eq 'title_3'
    expect(posts[2].content).to eq 'content_3'
    expect(posts[2].views).to eq 54
    expect(posts[2].user_account_id).to eq 2
  end

  # 2
  it "Get a single post" do
    repo = PostRepository.new

    post = repo.find(2)

    expect(post.id).to eq 2
    expect(post.title).to eq 'title_2'
    expect(post.content).to eq 'content_2'
    expect(post.views).to eq 254
    expect(post.user_account_id).to eq 1
  end


  # 3
  it "creates a new post" do
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = 'title_4'
    new_post.content = 'content_4'
    new_post.views = 1
    new_post.user_account_id = 1

    repo.create(new_post)

    posts = repo.all

    expect(posts.length).to eq 4
    expect(posts.last.title).to eq 'title_4'
    expect(posts.last.views).to eq 1
  end

  # 4
  it "updates a post" do
    repo = PostRepository.new

    updated_post = repo.find(1)
    updated_post.title = 'updated_title'
    updated_post.views = '300'

    repo.update(updated_post)

    post = repo.find(1)

    expect(post.title).to eq 'updated_title'
    expect(post.content).to eq 'content_1'
    expect(post.views).to eq 300
  end

  # 5
  it "deletes a post" do
    repo = PostRepository.new

    repo.delete(1)
    repo.delete(2)

    posts = repo.all

    expect(posts.length).to eq 1
    expect(posts[0].id).to eq 3
  end
end