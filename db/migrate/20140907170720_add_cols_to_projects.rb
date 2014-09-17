class AddColsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :name, :string
    add_column :projects, :complete, :integer
    add_column :projects, :description, :text
    # add_column :projects, :created_by, :reference
    add_reference :projects, :created_by, references: :users
  end
end
