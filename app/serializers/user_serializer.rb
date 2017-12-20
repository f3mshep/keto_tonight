class UserSerializer < ActiveModel::Serializer
  attributes :id, :admin, :email
  has_many :comments
end
