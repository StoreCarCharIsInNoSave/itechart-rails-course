# frozen_string_literal: true

class PersonCategory < ApplicationRecord
  belongs_to :person
  belongs_to :category
  has_many :money_transactions

  def debit_to_string
    category.debit ? 'Debit' : 'Credit'
  end

  def select_title
    "[Person]: #{person.title}, [Category]: #{category.title}, [Operation type]: #{debit_to_string}"
  end
end
