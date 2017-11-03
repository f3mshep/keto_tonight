class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
end
