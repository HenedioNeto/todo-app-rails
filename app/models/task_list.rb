class TaskList < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(:position) }, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
