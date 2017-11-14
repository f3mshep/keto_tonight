class RemoveLikesFromRecipes < ActiveRecord::Migration[5.1]
  def change
    remove_column :recipes, :likes, :integer
  end
end
