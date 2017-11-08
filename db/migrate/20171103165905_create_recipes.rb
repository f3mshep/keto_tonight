class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :likes, default: 1
      t.integer :calories
      t.integer :carbs
      t.integer :fat
      t.integer :protein
      t.integer :fiber
      t.belongs_to :user
      t.timestamps
    end
  end
end
