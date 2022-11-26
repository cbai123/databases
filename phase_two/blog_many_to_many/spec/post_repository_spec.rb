require 'post_repository'

RSpec.describe PostRepository do
  # 1
  it "Get all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 7
  end
  # 2
  it "Get a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq 1
    expect(post.title).to eq 'How to use Git'
  end
  # 3
  it "Get a post by tags" do
    repo = PostRepository.new

    posts = repo.find_by_tag('coding')

    expect(posts[0].id).to eq 1
    expect(posts[1].title).to eq 'Ruby classes'
    expect(posts[2].title).to eq 'Using IRB'
  end
end