class AddIngredientListToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :ingredient_list, :string
    add_column :recipes, :cook_time, :string
    add_column :recipes, :prep_time, :string
    add_column :recipes, :servings, :integer
  end
end
