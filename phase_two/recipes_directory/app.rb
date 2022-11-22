require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'
require_relative 'lib/recipe'

DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new

recipes = repo.all

recipes.each { |recipe|
  p recipe
}