class AddUserToTaskComment < ActiveRecord::Migration
  
  def change
  	add_reference :task_comments, :user, references: :users, index: true
  end

end
