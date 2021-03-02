class Tag < ApplicationRecord
  belongs_to :question

  validates :name, length: {maximum:100}, presence: :true
end
