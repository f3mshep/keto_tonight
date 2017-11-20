class RemoveFromIngredients < ActiveRecord::Migration[5.1]
  def change
    remove_column :ingredients, :calories, :integer
    remove_column :ingredients, :protein, :integer
    remove_column :ingredients, :fat, :integer
    remove_column :ingredients, :fiber, :integer
    remove_column :ingredients, :carbs, :integer
  end
end