class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.float :quantity
      t.string :measure
      t.timestamps
    end
  end
end
