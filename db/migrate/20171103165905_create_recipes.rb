class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.integer :likes
      t.belongs_to :user
      t.timestamps
    end
  end
end
