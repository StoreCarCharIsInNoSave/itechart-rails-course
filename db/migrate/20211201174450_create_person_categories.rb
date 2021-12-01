class CreatePersonCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :person_categories do |t|
      t.integer :person_id
      t.integer :category_id
    end
  end
end
