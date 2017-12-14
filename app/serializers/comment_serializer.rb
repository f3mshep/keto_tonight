class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content
  belongs_to :recipe
  belongs_to :user
end
