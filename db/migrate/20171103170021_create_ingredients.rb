class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :calories
      t.integer :protein
      t.integer :fat
      t.integer :fiber
      t.integer :carbs
      t.timestamps
    end
  end
end
