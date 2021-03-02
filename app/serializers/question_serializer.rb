class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user, :tags
end