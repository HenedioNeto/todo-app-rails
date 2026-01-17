class Task < ApplicationRecord
  belongs_to :task_list
  
  validates :description, presence: true
  
  # Define valor padrão para completed
  attribute :completed, :boolean, default: false
  
  # Ordena por position por padrão
  default_scope { order(:position) }
  
  # Define position automaticamente se não tiver
  before_create :set_default_position
  
  private
  
  def set_default_position
    return if position.present?
    max_position = task_list.tasks.maximum(:position) || 0
    self.position = max_position + 1
  end
end