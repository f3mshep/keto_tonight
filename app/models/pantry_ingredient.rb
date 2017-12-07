class PantryIngredient < ApplicationRecord
  belongs_to :pantry
  belongs_to :ingredient
  validates_uniqueness_of :pantry_id, :scope => :ingredient_id

  def ingredient_name
    ingredient.name
  end
  
end
