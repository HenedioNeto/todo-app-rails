class AddMoreFieldsToTasks < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :due_date, :datetime
    add_column :tasks, :priority, :integer
    add_column :tasks, :notes, :text
  end
end
