class PersonCategory < ApplicationRecord
  belongs_to :person
  belongs_to :category
  has_many :money_transactions
end
