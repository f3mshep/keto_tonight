class RecipeCategory < ApplicationRecord
  belongs_to :category
  belongs_to :recipe

  def self.recipes_by_category(category_id)
    recipe_categories = RecipeCategory.where(category_id: category_id)
    recipe_categories.collect {|recipe_category| recipe_category.recipe}
  end

end
