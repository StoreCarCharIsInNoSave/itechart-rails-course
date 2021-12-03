class Note < ApplicationRecord
  belongs_to :money_transaction, optional: true
end
