class Tag < ApplicationRecord
  validates :name, length: {maximum:100}, presence: :true
  validates :name, presence: :true
end
