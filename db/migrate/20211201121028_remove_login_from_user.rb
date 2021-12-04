# frozen_string_literal: true

class RemoveLoginFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :login, :string
  end
end
