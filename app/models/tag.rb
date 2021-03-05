# Tag model rules
class Tag < ApplicationRecord
  validates :name, length: { maximum: 100 }, presence: true
  validates :name, presence: true

  has_many :tag_question
  has_many :questions, through: :tag_question
end
