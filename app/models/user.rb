class User < ApplicationRecord
  has_many :recipes
  has_one :pantry
  has_many :comments
  has_many :likes
  has_many :liked_recipes, through: :likes, source: :recipe

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def likes_recipe(recipe)
    likes.detect do |like|
      like.recipe == recipe
    end
  end

  def pantry_ids
    pantry.ingredient_ids
  end

  def new_user?
    recipes.size < 1 && comments.size < 1 && likes.size < 1
  end

  def pantry_ingredients
    pantry.ingredients
  end

end
