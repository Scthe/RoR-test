class CreateTasks < ActiveRecord::Migration

  # rails generate model task project_id:references personResponsible:references title:string type:integer deadline:date description:text created_by:references

  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :type
      t.date :deadline
      t.text :description
      t.timestamps
    end

    add_reference :tasks, :project, references: :projects, index: true
    add_reference :tasks, :person_responsible, references: :users, index: true
    add_reference :tasks, :created_by, references: :users, index: true
  end
end
