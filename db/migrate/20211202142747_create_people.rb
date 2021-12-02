class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :title
      t.string :name
      t.string :lastname
      t.integer :user_id
      t.timestamps
    end
  end
end
