class Task < ApplicationRecord
  belongs_to :board
  validates :description, presence: true
end
