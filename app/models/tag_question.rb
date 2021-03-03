class TagQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :tag
end
