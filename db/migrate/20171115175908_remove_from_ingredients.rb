class RemoveFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :calories, :integer
    remove_column :recipes, :protein, :integer
    remove_column :recipes, :fat, :integer
    remove_column :recipes, :fiber, :integer
    remove_column :recipes, :carbs, :integer
  end
end