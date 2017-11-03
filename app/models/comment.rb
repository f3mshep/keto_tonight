class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
end
