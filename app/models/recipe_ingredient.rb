class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def name
    ingredient.name
  end

  def amount
    "#{quantity.to_mixed} #{measure}"
  end

end
