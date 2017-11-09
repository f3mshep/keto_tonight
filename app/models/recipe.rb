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
  validate :call_wrapper
  validate :add_nutrition
  validate :keto_friendly
  validate :save_food



  private


  def keto_friendly
    if self.errors.none?
      net_carb_serving = self.carbs - self.fiber / self.servings
      if net_carb_serving > SILLY_AMOUNT
        errors.add(:ingredients, "That recipe is definitely NOT keto friendly!")
      elsif net_carb_serving > MAX_CARBS
        errors.add(:ingredients, "There are too many net carbs per serving")
      end
    end
  end

  def call_wrapper
    wrapper = EdamamWrapper.new
    food_hash = wrapper.line_ingredient_parser(ingredient_list)
    self.food_hash = food_hash
    if food_hash.class == String
      errors.add(:ingredients, "#{food_hash}")
    end
  end

  def add_nutrition
    if self.errors.none?
      food_hash[:nutrients].each do |label, amount|
          recipe.send("#{label}=", amount)
      end
    end
  end

  def save_food
    if self.errors.none?
      food_hash[:ingredients].each do |ingredient, values|
        new_ingredient = Ingredient.find_or_create_by_food_id(values[:food_id], ingredient)
        RecipeIngredient.create(recipe: self, ingredient: new_ingredient, quantity: values[:quantity], measure: values[:measure] )
      end
    end
  end

end


#         module RecipesHelper

#     def add_nutrition(food_hash, recipe)
#         food_hash[:nutrients].each do |label, amount|
#             recipe.send("#{label}=", amount)
#         end
#     end

#     def add_ingredients(food_hash, recipe)
#         food_hash[:ingredients].each do |ingredient, values|
#             new_ingredient = Ingredient.find_or_create_by_food_id(values[:food_id], ingredient)
#             RecipeIngredient.create(recipe: recipe, ingredient: new_ingredient, quantity: values[:quantity], measure: values[:measure] )
#         end
#     end

# end


        # wrapper = EdamamWrapper.new
        # food_hash = wrapper.line_ingredient_parser(@recipe.ingredient_list)
        # add_nutrition(food_hash, @recipe)
        # if @recipe.save
        #     add_ingredients(food_hash, @recipe)
        #     redirect_to user_recipe_path(@recipe.user, @recipe)
        # else
        #     render :new
        # end