class Pantry < ApplicationRecord
  attr_accessor :no_food_id
  attr_accessor :not_unique
  belongs_to :user
  has_many :pantry_ingredients
  has_many :ingredients, through: :pantry_ingredients
  validate :has_food_id
  validate :is_unique_ingredient



  def ingredients_attributes=(ingredient)
    ingredient.values.each do |food_item|
      food_name = food_item[:name]
      wrapper = EdamamWrapper.new
      food_response = wrapper.ingredient_finder(food_name)
      begin
        food_id =  food_response.body["ingredients"][0]["parsed"][0]["foodId"]
        ingredient = Ingredient.find_or_create_by_food_id(food_id,food_name)
        pantry_ingredient = PantryIngredient.new(pantry_id: self.id, ingredient_id: ingredient.id)
        if pantry_ingredient.save
          self.save
        else
          self.not_unique = true
        end
      rescue
        self.no_food_id = food_name
      end
    end

  end

  def ingredient_ids
    ingredients.collect{|ingredient| ingredient.id}
  end

  private

  def is_unique_ingredient
    if not_unique
      errors.add(:ingredients, "That food is already in your pantry!")
    end
  end

  def has_food_id
    if no_food_id
      errors.add(:ingredients, "#{no_food_id} does not appear to be a valid food")
    end
  end

end
