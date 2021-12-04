# frozen_string_literal: true

class CreateMoneyTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :money_transactions do |t|
      t.integer :amount_value
      t.integer :note_id, null: true
      t.boolean :important, default: false
      t.integer :person_category_id
      t.timestamps
    end
  end
end
