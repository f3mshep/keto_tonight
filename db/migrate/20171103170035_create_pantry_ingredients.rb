class CreatePantryIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :pantry_ingredients do |t|
      t.belongs_to :pantry
      t.belongs_to :ingredient
      t.timestamps
    end
  end
end
