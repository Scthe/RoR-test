class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.integer :gender
      t.string :email
      t.string :password
      t.boolean :is_active
      t.date :birthdate

      t.timestamps
    end
  end
end
