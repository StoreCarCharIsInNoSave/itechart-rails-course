class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :body
      t.string :color
      t.boolean :important, default: false
      t.timestamps
    end
  end
end
