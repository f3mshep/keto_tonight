class Like < ApplicationRecord
    belongs_to :user
    belongs_to :recipe, counter_cache: true

   	def self.user_likes(user_id)
   		Like.select('likes.*').where("user_id = :id", {id: user_id})
   	end
end

#{Recipe.select('recipes.*').joins(:likes).group('recipes.id').having('count(likes.id) > 0')