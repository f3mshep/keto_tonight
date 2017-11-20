class Like < ApplicationRecord
    belongs_to :user
    belongs_to :recipe, counter_cache: true
end
