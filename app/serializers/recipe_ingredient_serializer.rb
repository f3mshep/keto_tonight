class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :measure, :ingredient_id
  belongs_to :recipe
  belongs_to :ingredient
end
