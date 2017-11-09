module RecipesHelper

    def add_nutrition(food_hash, recipe)
        food_hash[:nutrients].each do |label, amount|
            recipe.send("#{label}=", amount)
        end
    end

    def add_ingredients(food_hash, recipe)
        food_hash[:ingredients].each do |ingredient, values|
            new_ingredient = Ingredient.find_or_create_by_food_id(values[:food_id], ingredient)
            RecipeIngredient.create(recipe: recipe, ingredient: new_ingredient, quantity: values[:quantity], measure: values[:measure] )
        end
    end

end