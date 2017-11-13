class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :recipe
      t.timestamps
    end
  end
end
