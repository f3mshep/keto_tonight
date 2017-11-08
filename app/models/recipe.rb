class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :servings, presence: true
  validates :description, presence: true
  validates :ingredient_list, presence: true

end
