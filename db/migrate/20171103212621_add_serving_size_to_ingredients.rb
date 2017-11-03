class AddServingSizeToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :serving_size, :string
  end
end
