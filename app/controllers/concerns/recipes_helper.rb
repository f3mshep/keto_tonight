module RecipesHelper

    def add_nutrition(food_hash, recipe)
        food_hash[:nutrients].each do |label, amount|
            recipe.send("#{label}=", amount)
        end
    end

    def add_ingredients(food_hash, recipe)
        food_hash
    end

end