class AddServingSizeToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :serving_size, :integer
  end
end
