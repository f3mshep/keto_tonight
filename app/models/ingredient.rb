class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_ingredients
  has_many :pantries, through: :pantry_ingredients

  def self.find_or_create_by_food_id(food_id, name)
    food = self.find_by(food_id: food_id)
    if food
      food
    else
      Ingredient.create(name: name, food_id: food_id)
    end
  end

end
