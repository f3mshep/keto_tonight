class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :recipe_id, :username
  belongs_to :recipe
  belongs_to :user

  def username
    User.find(self.object.user_id).email
  end

end
