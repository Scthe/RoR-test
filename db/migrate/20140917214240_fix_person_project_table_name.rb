class FixPersonProjectTableName < ActiveRecord::Migration
  def change
  	rename_column :persons_in_project, :person_id, :user_id
  	rename_table :persons_in_project, :projectPerson
  end
end
