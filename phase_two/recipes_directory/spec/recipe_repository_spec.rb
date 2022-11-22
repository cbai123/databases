require 'recipe_repository'
require 'recipe'

RSpec.describe RecipeRepository do
  # 1
  it "gets all students" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2
    expect(recipes.first.id).to eq 1
    expect(recipes.first.name).to eq 'Air fryer salmon'
    expect(recipes[1].cooking_time).to eq 12
    expect(recipes[1].rating).to eq 4
  end

  # 2
  it "Gets a single recipe" do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.name).to eq 'Air fryer salmon'
    expect(recipe.cooking_time).to eq 15
    expect(recipe.rating).to eq 5
  end

  # 3 
  it "Gets a single recipe" do
    repo = RecipeRepository.new

    recipe = repo.find(2)

    expect(recipe.name).to eq 'Air fryer bacon'
    expect(recipe.cooking_time).to eq 12
    expect(recipe.rating).to eq 4
  end
end