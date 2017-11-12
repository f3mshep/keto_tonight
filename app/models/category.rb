class Category < ApplicationRecord
  has_many :recipe_categories
  has_many :recipes, through: :recipe_categories
  validates :name, uniqueness: true

  def show
    @recipes = Recipe
  end

end
