class Task < ApplicationRecord
  belongs_to :task_list
  
  validates :description, presence: true
  
  attribute :completed, :boolean, default: false

  scope :pending, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  
  default_scope { order(:position) }
  
  before_create :set_default_position
  
  private
  
  def set_default_position
    return if position.present?
    max_position = task_list.tasks.maximum(:position) || 0
    self.position = max_position + 1
  end
end