class CreateTaskComments < ActiveRecord::Migration
  def change
    create_table :task_comments do |t|
      t.string :text

      t.timestamps
    end

    add_reference :task_comments, :task, references: :tasks, index: true
  end
end
