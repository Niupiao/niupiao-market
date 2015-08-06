class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :body, :rating, :user
end
