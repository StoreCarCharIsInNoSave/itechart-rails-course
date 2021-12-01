class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :transaction_type
      t.timestamps
    end
  end
end
