class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_ingredients
  has_many :pantries, through: :pantry_ingredients
end
