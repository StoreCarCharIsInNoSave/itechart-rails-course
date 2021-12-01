class Person < ApplicationRecord
  belongs_to :user
  has_many :person_categories
  has_many :categories, through: :person_categories
  #get all MoneyTransactions for this person
end
