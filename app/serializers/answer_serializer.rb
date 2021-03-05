class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :user, :question
end
