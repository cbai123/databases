require 'tag_repository'

RSpec.describe TagRepository do
  # 1
  it "Get all tags" do
    repo = TagRepository.new

    tags = repo.all

    expect(tags.length).to eq 5
  end
  # 2
  it "Get a single tag" do
    repo = TagRepository.new

    tag = repo.find(1)

    expect(tag.id).to eq 1
    expect(tag.name).to eq 'coding'
  end
  # 3
  it "Get all tags from post" do
    repo = TagRepository.new

    tags = repo.find_by_post(6)

    expect(tags.length).to eq 2
    expect(tags.first.name).to eq 'travel'
    expect(tags.last.name).to eq 'cooking'
  end
end