require_relative './recipe'

class RecipeRepository
  def all
    sql = 'SELECT * FROM recipes;'

    results = DatabaseConnection.exec_params(sql,[])

    recipes = []

    results.each{ |entry|
      recipe = Recipe.new
      recipe.id = entry["id"].to_i
      recipe.name = entry["name"]
      recipe.cooking_time = entry["cooking_time"].to_i
      recipe.rating = entry["rating"].to_i

      recipes << recipe
    }

    return recipes
  end

  def find(id)
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql,params)

    result = result_set[0]

    recipe = Recipe.new
    recipe.id = result["id"].to_i
    recipe.name = result["name"]
    recipe.cooking_time = result["cooking_time"].to_i
    recipe.rating = result["rating"].to_i

    return recipe
  end
end