class Recipe < ApplicationRecord

  #scope in some ways appears to be a code style thing
  #I have elected to have all my methods that deal with AR
  #queries be scopes
  

  scope :by_ingredients, -> (ingredient_ids) { joins(:recipe_ingredients).where(recipe_ingredients: {ingredient_id: ingredient_ids}).distinct }
  
  #works in console, significant changes would need to be made to index action unless we use javascript. Come back to this one.
  scope :ingredient_names, -> (names) { joins(:ingredients).where(ingredients: {name: names}).distinct }
  scope :most_recent, -> {order('created_at DESC')}
  scope :by_category, -> (meal_category) {joins(:categories).where(categories: {name: meal_category})}
  scope :by_likes, -> { order('likes_count DESC') }
  scope :is_liked, -> {Recipe.joins(:likes).group("likes.recipe_id")}
  scope :search_query, -> (query) {Recipe.where("title like ?", "%#{query}%")}

  attr_accessor :food_hash
  MAX_CARBS = 20
  SILLY_AMOUNT = 100
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments
  has_many :recipe_categories
  has_many :categories, through: :recipe_categories
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  accepts_nested_attributes_for :categories, reject_if: :all_blank
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :servings, presence: true
  validates :description, presence: true
  validates :ingredient_list, presence: true
  validate :analyze_ingredients
  validate :keto_friendly

  #turned into a scope method. 
  # def self.find_recipe_by_ingredients(ingredient_ids)
  #   Recipe.joins(:recipe_ingredients).where(recipe_ingredients: {ingredient_id: ingredient_ids})
  # end

  def self.my_pantry(user)
    recipes =  by_ingredients(user.pantry_ids)
    recipes = recipes.sort_by {|recipe| recipe.missing_ingredients(user).size}
    recipes.delete_if {|recipe| recipe.missing_ingredients(user).size > 7}
  end

  def analyze_ingredients

    #is this a code smell??? I don't know. But it is the best way I can seem to handle validation using the API
    if ingredient_list
      wrapper = EdamamWrapper.new
      food_hash = wrapper.line_ingredient_parser(ingredient_list)
      self.food_hash = food_hash
      if food_hash.class == String
        errors.add(:ingredients, "#{food_hash}")
      else
        add_nutrition
      end
    end
  end

  def missing_ingredients(user)
    ingredients - user.pantry_ingredients
  end 

  def missing_ingredient_names(user)
    ingredients = missing_ingredients(user)
    ingredients.collect {|ingredient|ingredient.name}
  end

  def update_food
    ingredients.clear
    save_food
  end

  def save_food
    food_hash[:ingredients].each do |ingredient, values|
      new_ingredient = Ingredient.find_or_create_by_food_id(values[:food_id], ingredient)
      RecipeIngredient.create(recipe: self, ingredient: new_ingredient, quantity: values[:quantity], measure: values[:measure] )
    end
  end

  private

  def keto_friendly
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
