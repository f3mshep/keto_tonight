class CreateRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_categories do |t|
      t.integer :recipe_id
      t.integer :category_id

      t.timestamps
    end
  end
end
