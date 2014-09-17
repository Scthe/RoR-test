class CreateJoinTableProjectsPersons < ActiveRecord::Migration
  def change
  	 create_table :persons_in_project do |t|
      t.integer :role
    end

    add_reference :persons_in_project, :project, references: :projects, index: true
    add_reference :persons_in_project, :person, references: :users, index: true
  end
end
