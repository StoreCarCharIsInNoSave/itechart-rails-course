class MoneyTransaction < ApplicationRecord
  belongs_to :person_category
  belongs_to :note
end