class Pantry < ApplicationRecord
  attr_accessor :no_food_id
  belongs_to :user
  has_many :pantry_ingredients
  has_many :ingredients, through: :pantry_ingredients
  accepts_nested_attributes_for :ingredients
  validate :has_food_id



  def ingredients_attributes=(ingredient)
    food_name = ingredient["#{ingredients.size}"]["name"] #this wont blow up in my face. I promise.
    wrapper = EdamamWrapper.new
    food_response = wrapper.ingredient_finder(food_name)
    begin
      food_id =  food_response.body["ingredients"][0]["parsed"][0]["foodId"]
      ingredient = Ingredient.find_or_create_by_food_id(food_id,food_name)
      pantry_ingredient = PantryIngredient.create(pantry_id: self.id, ingredient_id: ingredient.id)
      self.save
    rescue
      self.no_food_id = food_name
    end
  end

  def ingredient_ids
    ingredients.collect{|ingredient| ingredient.id}
  end

  private

  def has_food_id
    if no_food_id
      errors.add(:ingredients, "#{no_food_id} does not appear to be a valid food")
    end
  end

end
