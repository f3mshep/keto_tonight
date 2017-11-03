class Pantry < ApplicationRecord
  belongs_to :user
  has_many :pantry_ingredients
  has_many :ingredients, through: :pantry_ingredients
end
