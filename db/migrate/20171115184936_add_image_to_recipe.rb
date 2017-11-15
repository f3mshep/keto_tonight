class AddImageToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :image, :string, default: 'https://i.imgur.com/D4OUBUs.jpg'
  end
end
