class Recipe < ApplicationRecord
  attr_accessor :food_hash
  MAX_CARBS = 20
  SILLY_AMOUNT = 100
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :servings, presence: true
  validates :description, presence: true
  validates :ingredient_list, presence: true
  validate :analyze_ingredients
  validate :keto_friendly


  def analyze_ingredients
    #is this a code smell??? I don't know. But it is the best way I can seem to handle validation using the API
    wrapper = EdamamWrapper.new
    food_hash = wrapper.line_ingredient_parser(ingredient_list)
    self.food_hash = food_hash
    if food_hash.class == String
      errors.add(:ingredients, "#{food_hash}")
    else
      add_nutrition
    end
  end


  def save_food
    food_hash[:ingredients].each do |ingredient, values|
      new_ingredient = Ingredient.find_or_create_by_food_id(values[:food_id], ingredient)
      RecipeIngredient.create(recipe: self, ingredient: new_ingredient, quantity: values[:quantity], measure: values[:measure] )
    end
  end

  private

  def keto_friendly
    binding.pry
    if self.errors.none?
      net_carb_serving = (self.carbs - self.fiber) / self.servings
      if net_carb_serving > SILLY_AMOUNT
        puts net_carb_serving
        errors.add(:ingredients, "That recipe is definitely NOT keto friendly!")
      elsif net_carb_serving > MAX_CARBS
        puts net_carb_serving
        errors.add(:ingredients, "There are too many net carbs per serving")
      end
    end
  end

  def add_nutrition
    food_hash[:nutrients].each do |label, amount|
        self.send("#{label}=", amount)
    end
  end

end
