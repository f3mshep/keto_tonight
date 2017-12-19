class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :calories, :carbs, :fat, :protein,
   :fiber, :cook_time, :prep_time, :servings, :image
  has_many :comments
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :categories
  has_many :likes
  belongs_to :user
end
