class AddLikesCountToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :likes_count, :integer, default: 0
  end
end
