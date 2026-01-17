class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :completed
      t.references :task_list, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
