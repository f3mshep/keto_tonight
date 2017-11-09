class Recipe < ApplicationRecord
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
  validate :keto_friendly

  def tamper_detection
    binding.pry
    if current_user.id != :user_id
      errors.add(:user_id, "Please don't tamper with hidden fields")
    end
  end

  def keto_friendly
    net_carb_serving = self.carbs - self.fiber / self.servings

    if net_carb_serving > SILLY_AMOUNT
      errors.add(:ingredients, "That recipe is definitely NOT keto friendly!")
    elsif net_carb_serving > MAX_CARBS
      errors.add(:ingredients, "There are too many net carbs per serving")
    end
  end

end
