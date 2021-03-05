class Question < ApplicationRecord
  belongs_to :user
  has_many :tag_question
  has_many :tags, :through => :tag_question
  has_many :answers

  validates :title, length: {minimum:10, maximum:100}, presence: :true
  validates :description, length: {minimum:10, maximum:1000}, presence: :true
end
