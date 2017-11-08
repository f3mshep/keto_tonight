module RecipesHelper

    def add_nutrition(food_hash, recipe)
        food_hash[:nutrients].each do |label, amount|
            recipe.send("#{label}=", amount)
        end
    end

    def add_ingredients(food_hash, recipe)
        food_hash[:ingredients].each do |ingredient, id|
            recipe.ingredients << Ingredient.find_or_create_by_food_id(id, ingredient)
        end
    end

end