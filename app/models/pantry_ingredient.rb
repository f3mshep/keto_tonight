class PantryIngredient < ApplicationRecord
  belongs_to :pantry
  belongs_to :ingredient
end
